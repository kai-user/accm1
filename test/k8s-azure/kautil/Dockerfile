FROM microsoft/dotnet:2.0-sdk-stretch
WORKDIR /build
COPY . .
RUN dotnet publish -c release -r debian.8-x64 -o publish \
    && chmod 755 publish/kautil
