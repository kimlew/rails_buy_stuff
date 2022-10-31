# BUY Stuff README

This uses a Docker image with MySQL with docker-compose.yml & migrates a previous Rails project that used Ruby 2.6.1, Rails 5.2.4.3 and PostgreSQL, to these versions and their dependencies:

- Docker 3.9
- Rails 7.0
- Ruby 3.1.2
- MySQL
- Puma 5.6

This Rails project:

- has scaffolding, standard CRUD actions and shopping cart (without purchasing part)
- includes: products, orders, line items, users, store, log in, log out, forms, sessions, admin, unit tests, integration tests, order notifications, etc.

## To run the application:

1. Run: `git clone git@github.com:kimlew/rails_buy_stuff.git`

2. Change to project directory with: `cd rails_buy_stuff`

3. Run: `docker compose up --build`

4. Go to browser address: <http://localhost:48019/>
