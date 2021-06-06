FROM golang:1.16 as build

WORKDIR /go/src/app

COPY go.mod .

RUN go mod download -x \
&&  rm go.mod

COPY . .

RUN go test -v. ./...

RUN go build -o /go/bin/app -v ./...

FROM gcr.io/distroless/base

COPY --from=build /go/bin/app /

CMD [ "/app" ]
