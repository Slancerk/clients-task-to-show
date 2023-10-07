FROM node:alpine
WORKDIR /usr/src/app
COPY package*.json .
RUN npm ci
COPY . .
CMD ["node","server.js"] 
#use this command to run in dev mode
#CMD ["npm","run","dev"]


# Use the .NET SDK image as the base image
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env

# Set the working directory inside the container
WORKDIR /app

# Copy the project files to the container
COPY *.csproj ./

# Restore the dependencies
RUN dotnet restore

# Copy the rest of the application code
COPY . ./

# Build the application
RUN dotnet build -c Release -o out

# Build the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:5.0

# Set the working directory inside the container
WORKDIR /app

# Copy the built application from the previous stage
COPY --from=build-env /app/out .

# Expose the desired port
EXPOSE 80

# Set the entry point for the container
ENTRYPOINT ["dotnet", "YourApplication.dll"]