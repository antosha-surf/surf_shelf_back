# Use the official Dart image
FROM dart:stable AS build

RUN useradd -u 1001 -m shelf

COPY . /shelf_server

WORKDIR /shelf_server

RUN dart pub get

RUN mkdir exe

RUN dart compile exe bin/surf_shelf.dart -o exe/surf_shelf

# Switch to the non-root user
USER shelf

EXPOSE 42069

CMD ["/shelf_server/exe/surf_shelf"]
