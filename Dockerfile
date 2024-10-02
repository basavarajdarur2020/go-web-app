FROM golang:1.21 as base
WORKDIR /app
COPY go.mod . 
RUN go mod download 
COPY . .
RUN go build -o main .
# final stage - Distroless image
FROM gcr.io/Distroless/base
COPY --from=base /app/main .
COPY --from=base /app/static ./static
EXPOSE 8080
CMD ["./main"]