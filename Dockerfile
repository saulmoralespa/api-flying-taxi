FROM ruby:3.3.0

WORKDIR /app

COPY . /app

RUN bundle install

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

ENV PORT 4567

EXPOSE $PORT

CMD ["bash", "-c", "rackup --host 0.0.0.0 -p $PORT"]