FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /app

COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o /publish

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime
WORKDIR /app
COPY --from=build /publish ./

# Dotnet 8 changed the default port from 80 to 8080 https://learn.microsoft.com/en-us/dotnet/core/compatibility/containers/8.0/aspnet-port
EXPOSE 8080 
ENTRYPOINT [ "dotnet", "DockerWebApi.dll" ]