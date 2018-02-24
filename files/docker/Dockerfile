FROM alpine:3.7
MAINTAINER flandiGT <https://github.com/flandiGT/ansible-teamspeak>

ENV LANG=C.UTF-8

# Here we install GNU libc (aka glibc) and set C.UTF-8 locale as default.

RUN ALPINE_GLIBC_BASE_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download" && \
    ALPINE_GLIBC_PACKAGE_VERSION="2.27-r0" && \
    ALPINE_GLIBC_BASE_PACKAGE_FILENAME="glibc-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
    ALPINE_GLIBC_BIN_PACKAGE_FILENAME="glibc-bin-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
    ALPINE_GLIBC_I18N_PACKAGE_FILENAME="glibc-i18n-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
    apk add --no-cache --virtual=.build-dependencies wget ca-certificates && \
    wget \
        "https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub" \
        -O "/etc/apk/keys/sgerrand.rsa.pub" && \
    wget \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" && \
    apk add --no-cache \
        "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" && \
    \
    rm "/etc/apk/keys/sgerrand.rsa.pub" && \
    /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 "$LANG" || true && \
    echo "export LANG=$LANG" > /etc/profile.d/locale.sh && \
    \
    apk del glibc-i18n && \
    \
    rm "/root/.wget-hsts" && \
    apk del .build-dependencies && \
    rm \
        "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME"

# Install teamspeak-server

EXPOSE 9987/udp 10011 30033

ENV \
	TS_DIR="/opt/teamspeak" \
	TS_RELEASE="http://dl.4players.de/ts/releases/3.1.0/teamspeak3-server_linux_amd64-3.1.0.tar.bz2" \
	TS_SHA="9f18cff600b9ce82a26ab788633cd5004bbe8c86963507efd3704c085f50a391" \
	TS_ARTIFACT="teamspeak.tar.bz2" \
	TS_DATA="/data" \
	TS3SERVER_LICENSE="accept"

RUN apk --update add tar \
	&& mkdir -p "${TS_DIR}" \
	&& wget "${TS_RELEASE}" -O "${TS_ARTIFACT}" \
	&& if [ $(sha256sum "${TS_ARTIFACT}" | cut -d" " -f 0) != $TS_SHA ]; then echo "CHECKSUM FAILED"; exit 1; fi \
	&& tar -xjf "${TS_ARTIFACT}" -C "${TS_DIR}" --strip-components=1 \
	&& rm "${TS_ARTIFACT}" "${TS_DIR}/CHANGELOG" "${TS_DIR}/libts3db_mariadb.so" \
	&& rm -r "${TS_DIR}/doc" "${TS_DIR}/redist" "${TS_DIR}/serverquerydocs" "${TS_DIR}/tsdns"

RUN mkdir -p ${TS_DATA}
VOLUME ${TS_DATA}
RUN for file in $(find ${TS_DATA} -mindepth 1 -maxdepth 1); do \
	ln -s "${file}" $(echo $file | sed 's@^'"${TS_DATA}"'@'"${TS_DIR}"'@g') \
	; done

RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*

COPY ./entrypoint.sh /entrypoint.sh
COPY ./handle_sqlite_location.sh /handle_sqlite_location.sh

ENTRYPOINT ["/entrypoint.sh"]
