# Deploy with Docker

## Step 1: create file .env

Create file .env or copy .env.example to .env

```bash
mv .env.example .env
```

## Step 2: Run containers Docker

```bash
docker-compose build
docker-compose up
```

## Step 3: Use REST API

# Request new Ride

```bash
curl --location 'http://localhost:4000/api/v1/request-ride' \
--header 'Content-Type: application/json' \
--data-raw '{
    "coordinates":[
        15.35567,
        30.98765
    ],
    "name": "Andres",
    "email": "andresperez@gmail.com",
    "phone": "3145671247"
}'
```

# Finish Ride

```bash
curl --location 'http://localhost:4000/api/v1/finish-ride/7' \
--header 'Content-Type: application/json' \
--data '{
    "end_location":[
        15.364728509,
        30.98765
    ]
}'
```


