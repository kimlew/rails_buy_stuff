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

# TEST if configuration is right. Start app with:
# CMD ["rails", "server", "-b", "0.0.0.0"]
# See if app runs in browser at: http://localhost:3000/
# Note: The rails server -b parameter with - has rails bind to all IPs & listen
# to requests from outside the container. Binding the server to 0.0.0.0 lets
# you view the app with your server's public IP address.

# Start/Run the main process.
RUN chmod +x launch_app.sh
CMD [ "/bin/bash", "-c", "bash launch_app.sh" ]
# View in browser at: http://localhost:48019/
