FROM microsoft/dotnet:2.1-runtime-deps-alpine3.7
MAINTAINER awyme qinmenghua@mail.com

RUN apk --no-cache add curl jq bash tree tzdata p7zip icu-libs && \
    cp -r -f /usr/share/zoneinfo/Hongkong /etc/localtime && \
    ASF_RELEASE_DATA=$(curl https://api.github.com/repos/JustArchi/ArchiSteamFarm/releases/latest | jq -r '.assets[] | select(.name | contains("ASF-generic.zip"))') && \
    ASF_TARBALL_FILE=$(echo $ASF_RELEASE_DATA | jq -r '.name') && \
    echo $ASF_RELEASE_DATA | jq -r '.browser_download_url' | xargs curl -LO && \
    apk --no-cache del curl jq tzdata && \
	mkdir /usr/local/asf/ && \
	mv $(basename $ASF_TARBALL_FILE) /usr/local/asf/ && \
	cd /usr/local/asf/ && \
	7z x $ASF_TARBALL_FILE && \
	chmod -R +x /usr/local/asf/ && \
    rm -f $ASF_TARBALL_FILE
    

CMD ["/usr/local/asf/ArchiSteamFarm.sh"]
