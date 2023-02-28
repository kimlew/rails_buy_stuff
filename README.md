# BUY Stuff README

This web app uses a Docker image with Ruby and Docker Compose, to run a Rails web app with a MySQL database & can be deployed on AWS.

It migrates a previous Rails project that used Ruby 2.6.1, Rails 5.2.4.3 and PostgreSQL, to these versions and their dependencies:

- Docker 3.9
- Rails 7.0
- Ruby 3.1.2
- MySQL
- Puma 5.6

This Rails project:

- has scaffolding, standard CRUD actions and shopping cart (without purchasing part)
- includes: products, orders, line items, users, store, log in, log out, forms, sessions, admin, unit tests, integration tests, order notifications, etc.

## To run the web app that is in a Docker container and Deployed on AWS

1. Create an EC2 instance on AWS with an Ubuntu image and at least a t2.micro size.

2. Create a security rule for TCP to use port 48019 and use that with the instance.

3. Run: `main.sh` Type .pem key and IP address.

4. Go to a browser and see the running app. Use the IP address of the instance and port, e.g., `<http://54.190.12.61:48019>`


## To locally run the app in a Docker container using Docker Compose

1. Clone the repo: `git clone git@github.com:kimlew/rails_buy_stuff.git`

2. Change to project directory with: `cd rails_buy_stuff`
   
3. Create an `.env` file with environment variables similar to the example below. Assign values to the MySQL root user and the MySQL user along with **passwords**, which **should NOT be shown to anyone**.

  ```
    MYSQL_ROOT_USER=root
    MYSQL_ROOT_PASSWORD=therootuserpassword
    MYSQL_USER=yourmysqluser
    MYSQL_PASSWORD=yourmysqluserpassword
    MYSQL_DATABASE=rails_buy_stuff_development
    PORT_ASSIGNED_ON_HOST_FOR_DB=48018
    PORT_ASSIGNED_ON_HOST_FOR_WEB_APP=48019
    PORT_RAILS_WEB_SERVER_DEFAULT=3000
    PORT_MYSQL_SERVER_DEFAULT=3306
  ```

4. Run: `docker compose up --build`

5. Go to browser address: `<http://localhost:48019/>`
