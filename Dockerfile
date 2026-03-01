# Fase di compilazione
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia i file e compila
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Immagine finale leggera
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "CiaoMondoApi.dll"]