FROM golang:1.22.1

# Set destination for COPY
WORKDIR /app

# Download Go modules
COPY go.mod go.sum ./
RUN go mod download

# Copy the source code. Note the slash at the end, as explained in
COPY . ./

RUN mv -f ./conf/app-release.ini ./conf/app.ini

# Build
# GIN_MODE=release
RUN CGO_ENABLED=0 GOOS=linux go build -gcflags="-N -l" -o main .

EXPOSE 8081

# Run
CMD ["./main"]