# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /source/AspNetApp
WORKDIR /source

# Copy csproj and restore as distinct layers
COPY AspNetApp/*.csproj ./AspNetApp/
RUN dotnet restore AspNetApp/
COPY AspNetApp/. ./AspNetApp/

# Copy the rest of the application and publish
COPY . .
WORKDIR /source/AspNetApp
RUN dotnet publish -c Release -o /source/publish --no-restore

# Stage 2: Run the application
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS final
WORKDIR /app/src
EXPOSE 8080 

# Set the entry point to run the application
#ENTRYPOINT ["dotnet", "AspNetApp.dll"]