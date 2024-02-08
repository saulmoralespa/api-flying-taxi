require 'spec_helper'

describe 'ApiV1Controller' do
  describe 'GET /api/v1/drivers' do
    it 'returns status code 200' do
      get '/api/v1/drivers'
      expect(last_response.status).to eq(200)
    end

    it 'returns drivers as JSON' do
      get '/api/v1/drivers'
      expect(last_response.header['Content-Type']).to include 'application/json'
    end
  end

  describe 'POST /api/v1/request-ride' do
    let(:valid_params) do
      {
        coordinates: [15.35567, 30.98765],
        name: 'John Doe',
        email: 'john@example.com',
        phone: '1234567890'
      }
    end

    it 'returns status code 200' do
      post '/api/v1/request-ride', valid_params.to_json
      expect(last_response.status).to eq(200)
    end

    it 'returns nearest driver as JSON' do
      post '/api/v1/request-ride', valid_params.to_json
      expect(last_response.header['Content-Type']).to include 'application/json'
    end
  end

  describe 'POST /finish-ride/:id' do

    let(:ride_id) { 123 }
    let(:end_location) { [15.12345, 30.98765] }

    context 'when the ride exists' do
      before do
        allow(Ride).to receive(:find_by).with(id: ride_id).and_return(double('Ride', id: ride_id, end_time: nil, start_location: [15.34567, 30.98765]))
        allow(Geocoder::Calculations).to receive(:distance_between).and_return(1.0)
        allow(Time).to receive(:now).and_return(Time.new(2024, 2, 8, 12, 0, 0))
      end

      it 'finishes the ride and returns a response' do
        post "/finish-ride/#{ride_id}", { end_location: end_location }.to_json

        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)).to include('success' => true)
      end
    end

    context 'when the ride does not exist' do
      before do
        allow(Ride).to receive(:find_by).with(id: ride_id).and_return(nil)
      end

      it 'returns a 404 error' do
        post "/finish-ride/#{ride_id}", { end_location: end_location }.to_json

        expect(last_response.status).to eq(404)
        expect(JSON.parse(last_response.body)).to include('error' => 'Ride not found')
      end
    end

  end

end