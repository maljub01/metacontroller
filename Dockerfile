FROM golang:1.14.4 AS build

COPY . /go/src/metacontroller.io/
WORKDIR /go/src/metacontroller.io/
ENV CGO_ENABLED=0
RUN make vendor && go install

FROM alpine:3.12.2
COPY --from=build /go/bin/metacontroller.io /usr/bin/metacontroller
RUN apk update && apk add --no-cache ca-certificates
CMD ["/usr/bin/metacontroller"]
