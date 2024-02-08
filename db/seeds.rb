Rider.create!(
  name: "Carlos  Monsalve",
  email: "carlosmonsalve@example.com",
  phone_number: "3173451200"
)
Rider.create!(
  name: "Estela Garcia",
  email: "estelagarcia@example.com",
  phone_number: "3133451205"
)
Rider.create!(
  name: "Juana Corredor",
  email: "juanacorredor@example.com",
  phone_number: "3233451255"
)

Driver.create!(
  name: 'Michael Brown',
  location: [ 10.12345, 20.54321 ]
)
Driver.create!(
  name: 'Emma Davis',
  location: [ 12.98765, 25.12345 ]
)
Driver.create!(
  name: 'William Miller',
  location: [ 15.34567, 30.98765 ]
)

Ride.create!(
  riders_id: 1,
  drivers_id: 1,
  start_location: [ 10.11111, 20.22222 ],
  end_location: [ 11.11111, 21.22222 ],
  start_time: '2023-01-01 09:00:00',
  end_time: '2023-01-01 09:30:00',
  distance: 10.5
)
Ride.create!(
  riders_id: 2,
  drivers_id: 2,
  start_location: [ 12.22222, 22.33333 ],
  end_location: [ 13.22222, 23.33333 ],
  start_time: '2023-01-02 10:00:00',
  end_time: '2023-01-02 10:45:00',
  distance: 15.3
)
Ride.create!(
  riders_id: 3,
  drivers_id: 3,
  start_location: [ 14.44444, 24.55555 ],
  end_location: [ 15.44444, 25.55555 ],
  start_time: '2023-01-03 11:00:00',
  end_time: '2023-01-03 11:15:00',
  distance: 8.2
)

Payment.create!(
  riders_id: 1,
  amount: 12500.75
)
Payment.create!(
  riders_id: 2,
  amount: 18500.25
)
Payment.create!(
  riders_id: 3,
  amount: 9500.50
)