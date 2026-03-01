# Fase di Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copiamo tutto il contenuto della cartella corrente
COPY . .

# --- DIAGNOSTICA ---
# Questo comando stamperà nella console di GitHub i file che Docker vede.
# Ci aiuterà a capire se il .csproj è nella root o in una sottocartella.
RUN ls -R
# -------------------

# Eseguiamo il restore puntando esplicitamente alla cartella corrente
RUN dotnet restore "./CiaoMondoApi.csproj" || dotnet restore

RUN dotnet publish -c Release -o /app/publish

# Fase di Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "CiaoMondoApi.dll"]