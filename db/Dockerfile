FROM golang:1.18-alpine as builder

ADD .. /go/src/github.com/vulcanize/filecoin-indexing

# Get migration tool
WORKDIR /
ARG GOOSE_VER="v3.6.1"
ADD https://github.com/pressly/goose/releases/download/${GOOSE_VER}/goose_linux_x86_64 ./goose
RUN chmod +x ./goose

# app container
FROM alpine

WORKDIR /app

COPY --from=builder /go/src/github.com/vulcanize/filecoin-indexing/db/scripts/startup_script.sh .

COPY --from=builder /goose goose
COPY --from=builder /go/src/github.com/vulcanize/filecoin-indexing/db/migrations migrations

ENTRYPOINT ["/app/startup_script.sh"]
