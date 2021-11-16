# AspNet minimal API example

Net 6.0 version. 

1. Docker image size 48.1MB (COMPRESSED SIZE 20.19MB). TrimMode=Link
2. Docker image size 60.1MB. TrimMode=CopyUsed
3. Docker over HTTP.  RAM consumption 24MB+. For ingress controller
4. Docker over HTTPS. RAM consumption 32MB+


```bash
# create project command example
dotnet new webapi --no-https --use-minimal-apis --no-openapi -o MyMinimalApi

# local run
dotnet run --urls https://+:8001
open https://localhost:8001

# build docker
docker build -t vahpetr/aspnet-minimal-api-example . --no-cache

# docker over HTTP. P.S. Insecure connection not work in google chrome
docker run --rm -it -p 8000:80 -e ASPNETCORE_URLS="http://+:80" vahpetr/aspnet-minimal-api-example
open https://localhost:8000

# docker over HTTPS. Secure connection work in google chrome
dotnet dev-certs https -ep ${HOME}/.aspnet/https/aspnetapp.pfx -p password
dotnet dev-certs https --trust
docker run --rm -it -p 8000:80 -p 8001:443 \
    -e ASPNETCORE_URLS="http://+:80;https://+:443" \
    -e ASPNETCORE_Kestrel__Certificates__Default__Password="password" \
    -e ASPNETCORE_Kestrel__Certificates__Default__Path=/https/aspnetapp.pfx \
    -v ${HOME}/.aspnet/https:/https/ \
    vahpetr/aspnet-minimal-api-example
open https://localhost:8001

# dockerimage publish
docker image push vahpetr/aspnet-minimal-api-example:latest
```

## Links

1. [Dockerhub vahpetr/aspnet-minimal-api-example](https://hub.docker.com/repository/docker/vahpetr/aspnet-minimal-api-example)
2. [.NET](https://dotnet.microsoft.com/)
3. [Download .NET](https://dotnet.microsoft.com/download)
4. [Документация по ASP.NET](https://docs.microsoft.com/ru-ru/aspnet/core/?view=aspnetcore-6.0)
5. [Hosting ASP.NET Core images with Docker over HTTPS](https://docs.microsoft.com/en-us/aspnet/core/security/docker-https?view=aspnetcore-6.0)
6. [Hosting ASP.NET Core images with Docker Compose over HTTPS](https://docs.microsoft.com/en-us/aspnet/core/security/docker-compose-https?view=aspnetcore-6.0)
7. [Trimming options](https://docs.microsoft.com/en-us/dotnet/core/deploying/trimming/trimming-options)
