FROM microsoft/dotnet:2.1-runtime-deps-alpine3.7
MAINTAINER awyme qinmenghua@mail.com

RUN apk --no-cache add curl jq bash tree tzdata unzip icu-libs \
    cp -r -f /usr/share/zoneinfo/Hongkong /etc/localtime \
    ASF_RELEASE_DATA=$(curl https://api.github.com/repos/JustArchi/ArchiSteamFarm/releases/latest | jq -r '.assets[] | select(.name | contains("ASF-generic.zip"))') && \
    ASF_TARBALL_FILE=$(echo $ASF_RELEASE_DATA | jq -r '.name') && \
    echo $ASF_RELEASE_DATA | jq -r '.browser_download_url' | xargs curl -LO && \
    apk --no-cache del curl jq bash tree tzdata unzip icu-libs&& \
    unzip $ASF_TARBALL_FILE && \
    rm -f $ASF_TARBALL_FILE && \
    mv $(basename $ASF_TARBALL_FILE.zip) /usr/local/asf && \

CMD ["/usr/local/asf/ArchiSteamFarm"]
