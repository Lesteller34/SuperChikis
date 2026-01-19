FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["SuperChiki2.csproj", "./"]
RUN dotnet restore "SuperChiki2.csproj"
COPY . .
RUN dotnet build "SuperChiki2.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "SuperChiki2.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SuperChiki2.dll"]