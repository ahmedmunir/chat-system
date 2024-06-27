FROM ruby:3.1.2

# Update package lists and install necessary packages
RUN apt-get update -qq && apt-get install -y nodejs default-mysql-client redis-tools

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app

# Copy the entrypoint scripts into the container
COPY entrypoint.sh /usr/bin/
COPY sidekiq_entrypoint.sh /usr/bin/

# Make the entrypoint scripts executable
RUN chmod +x /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/sidekiq_entrypoint.sh

EXPOSE 3000

# Set the entrypoint script
ENTRYPOINT ["entrypoint.sh"]

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
