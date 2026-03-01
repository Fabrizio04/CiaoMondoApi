# Fase di compilazione
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# 1. Copia solo il file di progetto e ripristina le dipendenze
# Questo passaggio è separato per sfruttare la cache di Docker
COPY *.csproj ./
RUN dotnet restore

# 2. Copia tutto il resto e compila
COPY . .
RUN dotnet publish -c Release -o /publish

# Fase finale: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# 3. Copia i file compilati dalla cartella /publish della fase precedente
COPY --from=build /publish .

# 4. Assicurati che il nome della DLL sia corretto!
ENTRYPOINT ["dotnet", "CiaoMondoApi.dll"]