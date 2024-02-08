require 'sinatra'
require 'sinatra/namespace'
require 'geocoder'
require 'httparty'
require 'json'
require_relative '../../helpers'

class ApiV1Controller < Sinatra::Base
  register Sinatra::Namespace

  namespace '/api/v1' do

    before do
      content_type :json
    end

    get '/drivers' do
      Driver.all.to_json

    end

    post '/request-ride' do

      request_body = JSON.parse(request.body.read)

      unless request_body.key?('coordinates') && request_body.key?('name') && request_body.key?('email') && request_body.key?('phone')
        status 400
        return { error: 'Missing parameters' }.to_json
      end

      coordinates = request_body['coordinates']
      name = request_body['name']
      email = request_body['email']
      phone = request_body['phone']

      all_drivers = Driver.all

      min_distance = nil
      nearest_driver = nil

      all_drivers.each do |driver|

        distance = Geocoder::Calculations.distance_between(driver['location'], coordinates)

        if min_distance.nil? || distance < min_distance
          min_distance = distance
          nearest_driver = driver
        end

      end

      if nearest_driver

        rider = Rider.create!(
          name: name,
          email: email,
          phone_number: phone
        )

        ride = Ride.create!(
          riders_id: rider.id,
          drivers_id: nearest_driver.id,
          start_location: coordinates,
          start_time: Time.now
        )

        { id_ride: ride.id, driver_name: nearest_driver.name, rider_name:  rider.name, ride_start_location: ride.start_location }.to_json
      else

        error_message = { error: 'No se encontraron conductores cercanos' }.to_json
        status 404
        body error_message
      end

    end


    post '/finis-ride/:id' do |id|
      ride = Ride.find_by(id: id)

      if ride

        if ride.end_time
          status 400
          return { error: 'Ride finish' }.to_json
        end

        request_body = JSON.parse(request.body.read)

        unless request_body.key?('end_location')
          status 400
          return { error: 'Missing parameter end_location' }.to_json
        end

        end_location = request_body['end_location']
        end_time = Time.now

        distance = Geocoder::Calculations.distance_between(ride.start_location, end_location)

        ride.update(end_location: end_location, end_time: end_time, distance:distance)

        total = 3500
        total += distance.round * 1000
        total += minutes_between(ride.start_time, end_time) * 200
        amount_in_cents = total * 100

        reference = "ride#{ride.id}"
        currency = 'COP'

        signature = "#{reference}#{amount_in_cents}#{currency}#{ENV["SECRET_INTEGRITY"]}"
        signature = Digest::SHA2.hexdigest(signature)
        rider = ride.rider

        bearer_token = ENV["KEY_PRIVATE"]
        request_body = {
          amount_in_cents: amount_in_cents,
          currency: currency,
          signature: signature,
          customer_email: rider.email,
          payment_method: {
            installments: 1
          },
          reference: reference,
          payment_source_id: ENV["PAYMENT_SOURCE_ID"]
        }

        response = HTTParty.post(
          "https://sandbox.wompi.co/v1/transactions",
          body: request_body.to_json,
          headers: {
            "Content-Type" => "application/json",
            "Authorization" => "Bearer #{bearer_token}"
          }
        )

        Payment.create!(
          riders_id: ride.id,
          amount: total
        )

        response.to_json
      else
        status 404
        { error: 'Ride not found' }.to_json
      end
    end

  end
end