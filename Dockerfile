FROM instrumentisto/flutter
WORKDIR /app
ENV CHANNEL=stable
ENV BUILD=web
RUN flutter channel ${CHANNEL}
RUN flutter upgrade
VOLUME [ "/app" ]
CMD ["./pubget.sh"]
