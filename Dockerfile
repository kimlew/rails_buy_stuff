FROM ruby:3.1.2 AS rails-toolbox

RUN apt update && apt install -y \
  nodejs \
  nano \
  rbenv

# Set default working directory as app's root directory.
ENV INSTALL_PATH /opt/rails_buy_stuff
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile.lock ./
RUN bundle check || bundle install
COPY . ./
RUN gem install rails -v 7 && gem install bundler -v 2.3.22
RUN bundle install

# TEST if container working right by running a shell. Comment out after test
# since only 1 CMD allowed per Dockerfile & need that 1 CMD to run web app.
#CMD ["/bin/sh"]

# Default port is 3000 for host. Note: In recent versions of Dockerfile, EXPOSE
# is just informative. EXPOSE no longer has any operational impact.
# EXPOSE 3000

# An entrypoint script is executed every time the container starts. This lets us
# run the container as an executable.
# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]

# TEST if configuration is right. Start rails app & see if app runs in browser.
# From the application's directory, use command: bin/rails s --binding=0.0.0.0
# Binding the server to 0.0.0.0 - lets you view the app w your server's public
# IP address. View in browser at: http://localhost:3000/

# Start/Run the main process, i.e., configure main process to run when running
# the image. Note: Use the rails server -b parameter - to have rails bind to all
# IPs & listen to requests from outside the container. Refer to:
# https://stackoverflow.com/questions/61164093/docker-compose-rails-app-not-accessible-on-port-3000#61164280

# B4: CMD ["rails", "server", "-b", "0.0.0.0"] # Took out: rake db:drop
# TODO: Put commands in in shell script & run script so shorter line, e.g., launch.sh
# COPY startup.sh .
# CMD ["/bin/bash","-c","./startup.sh"]
#CMD ["/bin/bash", "-c", "rails db:create && rails db:migrate && rails db:seed && rails db:schema:load && rails db:load && rails server -b 0.0.0.0"]
#CMD ["rails", "server", "-b", "0.0.0.0"]
CMD [ "/bin/bash", "-c", "rails db:migrate RAILS_ENV=development && rails db:seed && rails server -b 0.0.0.0" ]
# View in browser at: http://localhost:48019/
