FROM openjdk:11.0.2
RUN apt-get update
WORKDIR /usr/src
COPY ./micro-volunteer-pf /usr/src
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ JST-9
ENV TERM xterm
ENV TARGET micro-volunteer-pf
RUN /usr/src/gradlew build -x test
