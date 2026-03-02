# 1. Fase di Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copia il file di progetto usando il wildcard per non sbagliare maiuscole
COPY *.csproj ./
RUN dotnet restore

# Copia tutto il resto (ora che Program.cs è corretto)
COPY . .

# Pubblica in modalità Release nella cartella /app/out
RUN dotnet publish -c Release -o /app/out

# 2. Fase di Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Copia i binari dalla fase di build
COPY --from=build /app/out .

# Usa il wildcard anche qui per far partire la DLL qualunque sia il nome
ENTRYPOINT ["sh", "-c", "dotnet *.dll"]