# Use an official Flutter image as the base image
FROM cirrusci/flutter:stable AS build

# Set the working directory to /app
WORKDIR /app

# Copy the Flutter app source code into the container
COPY . .

# Build the Flutter application for release
RUN flutter build apk --release

# Use a minimal Nginx image as the final image
FROM nginx:alpine

# Copy the built APK from the Flutter image to the Nginx image
COPY --from=build /app/build/app/outputs/flutter-apk/app-release.apk /usr/share/nginx/html/app-release.apk

# Expose port 80 for Nginx
EXPOSE 80

# Start Nginx to serve the Flutter app
CMD ["nginx", "-g", "daemon off;"]
