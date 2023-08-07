FROM alpine

ENV GO /usr/local/go
ENV PIXLET /pixlet
ENV PATH "${PATH}:${GO}/bin:${PIXLET}"

ARG TZ
ENV TZ=$TZ

#install prereqs
RUN apk update && \
    apk upgrade -U && \
    apk add tzdata nano curl wget git make libc-dev gcc ca-certificates npm libwebp-dev libwebp-tools patchelf gcompat go && \
    rm -rf /var/cache/*

#Download Pixlet
RUN git clone https://github.com/tidbyt/pixlet.git $PIXLET
WORKDIR $PIXLET

#Build Pixlet
RUN npm install && npm run build
RUN make build

EXPOSE 8080
