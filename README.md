# Bowling Game API

This is a Ruby on Rails API for a bowling game that allows users to start a new game, input scores, and retrieve the current game status. The API can be used by bowling alleys to keep track of scores and provide real-time updates.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Setting Up the Environment](#setting-up-the-environment)
  - [Running the Application](#running-the-application)
    - [Without Docker](#without-docker)
    - [With Docker](#with-docker)
  - [Testing](#run-tests)
  - [API Documentation](#api-documentation)

## Features

- Start a new bowling game
- Input the number of pins knocked down by each roll
- Retrieve the current game status, including scores for each frame and total score
- Handle strikes and spares according to standard bowling rules

## Getting Started

### Prerequisites
To run this application, you'll need:
- Ruby (version 3.2.0)
- Rails (version 7.0.8)
- PostgreSQL (version 14)
- Docker

## Setting Up the Environment
### 1. Clone the Repository
```sh
git clone https://github.com/Haseeb717/bowling-game
cd bowling-game
```

## Running the Application
### Without Docker

### 1. Install Dependencies
```sh
bundle install
```

### 2. Database configuration
```sh
rails db:create
rails db:migrate
```

### 3. Rails Server

Run the rails server on console with port 3000:

```sh
rails s -p 3000
```

### With Docker

### 1. Build the Docker image:
```sh
  docker-compose build
```

### 2. Start the containers:
```sh
docker-compose up
```

### 3. Run database migrations:
```sh
docker-compose run web rails db:create
docker-compose run web rails db:migrate
```

### Run Tests

Execute the test suite:

```sh
bundle exec rspec
```

### API Documentation
The API documentation is available via Swagger. You can access it at http://localhost:3000/api-docs after starting the application. This documentation includes all the available endpoints and their usage.
