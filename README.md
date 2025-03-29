# Event Booking App

## Prerequisites

Ensure you have the following installed:

- **Ruby** (Version 3.0.0)
- **Rails** (Version 7.1.5.1)
- **Bundler** (`gem install bundler`)
- **SQLite**
- **Redis** (for Sidekiq background jobs)

## Instructions to Follow

1. Open your terminal in a folder.
2. Run the following commands:
   ```sh
   git init
   git clone https://github.com/saroj-sahu-developer/event_management_app
   cd event_management_app
   bundle install
   rails db:migrate
   rails s
   ```
3. Now the Rails app will run, and you can test the APIs in Postman.

## To Check Asynchronous Jobs

1. Run the Redis server.
2. Update `config/initializers/sidekiq.rb` file as per your Redis server port.
3. In the project directory, run:
   ```sh
   bundle exec sidekiq
   ```
4. To test in Rails console, you can run:
   ```sh
   EventUpdateNotificationJob.new.perform(<event_id>)
   TicketConfirmationJob.new.perform(<booking_id>)
   ```

Additional Information

Please check the shared documentation.

You can import the shared Postman collection file to Postman to make it easy to test the APIs.





