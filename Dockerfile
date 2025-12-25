FROM ghcr.io/cirruslabs/flutter:3.24.3

WORKDIR /app

# Precache dependencies
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# Copy the rest of the project
COPY . .

# Fetch again with sources available (and offline cache warm)
RUN flutter pub get --offline

EXPOSE 8080

CMD ["dart", "run", "lib/backend/server.dart", "8080"]
