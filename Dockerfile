FROM ruby:3.1.2

ARG DOCKER_UID=1001
ARG DOCKER_USER=docker
ARG DOCKER_PASSWORD=docker
RUN useradd -m --uid ${DOCKER_UID} --groups sudo ${DOCKER_USER} \
&& echo ${DOCKER_USER}:${DOCKER_PASSWORD} | chpasswd
RUN apt update && apt install sudo
RUN echo 'Defaults visiblepw'             >> /etc/sudoers
RUN echo 'docker ALL=(ALL) NOPASSWD:ALL'  >> /etc/sudoers

WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
RUN chown ${DOCKER_USER}:${DOCKER_USER} -R /myapp
# 作成したユーザーに切り替える
USER ${DOCKER_USER}
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
