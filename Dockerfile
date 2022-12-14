FROM golang:1.19.1-alpine

RUN apk update && apk add git


RUN go install -v golang.org/x/tools/gopls@latest \
	&& go install -v github.com/ramya-rao-a/go-outline@latest \
	&& go install -v golang.org/x/tools/cmd/goimports@latest \
	&& go install -v github.com/mdempsky/gocode@latest

RUN mkdir /go/src/app
WORKDIR /go/src/app
RUN alias g='git'
COPY go.mod ./
ENV CGO_ENABLED 0 
RUN go mod download && go mod verify
