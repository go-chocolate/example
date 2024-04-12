FROM golang:1.20-alpine AS builder

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk update && apk add --no-cache tzdata
RUN apk add git

WORKDIR /opt/app

ADD . .

#RUN commit_id=$(git rev-parse HEAD)
RUN datetime=$(date '+%Y-%m-%d %H:%M:%S')
RUN go build -ldflags "-X github.com/go-chocolate/example/version.BuildTime=$datetime -X github.com/go-chocolate/example/version.BuildHash=$commitid" -o example main.go

FROM alpine:latest AS runner

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /usr/share/zoneinfo/Asia/Shanghai /usr/share/zoneinfo/Asia/Shanghai

ENV TZ Asia/Shanghai

WORKDIR /opt/app

COPY --from=builder /opt/app/example .
COPY --from=builder /opt/app/etc .

ENTRYPOINT ./example