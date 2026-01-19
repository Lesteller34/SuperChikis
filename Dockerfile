# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0.404 AS build
WORKDIR /src

# Cambiar aquí el nombre del proyecto
COPY ["ListaSupermercado.csproj", "./"]
RUN dotnet restore "ListaSupermercado.csproj"

COPY . .
RUN dotnet build "ListaSupermercado.csproj" -c Release -o /app/build

# Publish stage
FROM build AS publish
RUN dotnet publish "ListaSupermercado.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0.11 AS final
WORKDIR /app
EXPOSE 8080

COPY --from=publish /app/publish .

# Cambiar también el nombre del DLL
ENTRYPOINT ["dotnet", "ListaSupermercado.dll"]
