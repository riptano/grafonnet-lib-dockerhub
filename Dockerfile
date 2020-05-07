# Install required libraries
FROM golang:1.11.1-alpine AS builder

RUN apk add --no-cache git build-base && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/google/jsonnet.git && \
    make -C jsonnet

RUN go get github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb && \
    jb init && \
    jb install https://github.com/grafana/grafonnet-lib/grafonnet && \
    jb install https://github.com/thelastpickle/grafonnet-polystat-panel

# Create image for dashboard generation
FROM alpine:3.8

RUN apk add --no-cache libstdc++ ca-certificates

WORKDIR /dashboards

COPY --from=builder /go/vendor vendor
COPY --from=builder /go/jsonnet/jsonnet /usr/local/bin/

ENV JSONNET_PATH=/dashboards/vendor
CMD [ "jsonnet", "-" ]
