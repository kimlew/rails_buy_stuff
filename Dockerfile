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

# Start/Run the main process.
RUN echo "LAUNCHING Buy Stuff"
# Note: /bin/bash is the executable program & already has permissions to execute
# scripts, so no chmod +x needed.
CMD [ "/bin/bash", "-f", "launch_app.sh" ]
# See locally running app with Docker & Docker Compose at: http://localhost:48019/
# Note: Runs in container on port 3000 but I forwarded port to 48019.
# See running app on AWS with: http://IPaddress:48019
