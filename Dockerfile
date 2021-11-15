FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS sdk

WORKDIR /app

COPY AspNetMinimalApi.csproj ./
RUN dotnet restore -r alpine-x64

COPY . .

# -p:TrimMode=CopyUsed
RUN dotnet publish ./AspNetMinimalApi.csproj -r alpine-x64 -c Release -o ./publish --no-restore --self-contained true -p:PublishTrimmed=True -p:TrimMode=Link -p:PublishSingleFile=true

FROM mcr.microsoft.com/dotnet/runtime-deps:6.0-alpine as runtime

WORKDIR /app
COPY --from=sdk /app/publish .
ENTRYPOINT ["./AspNetMinimalApi"]
