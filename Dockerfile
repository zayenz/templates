# Set up builder environment for static linking with musl
# In particular, a separate layer is added for the dependencies 
# to avoid excessive re-building.
# 
FROM ekidd/rust-musl-builder:nightly AS builder

#USER rust
RUN USER=rust cargo init
COPY Cargo.toml Cargo.lock /home/rust/src/
RUN sudo chown rust:rust Cargo.toml Cargo.lock
RUN cargo build --release

# Add real source code
COPY . /home/rust/src/
RUN sudo chown -R rust:rust .

# Build our application.
RUN USER=rust cargo build --release

# Create runner 
#
#
FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=builder \
  /home/rust/src/target/x86_64-unknown-linux-musl/release/hello \
  /usr/local/bin/
CMD /usr/local/bin/hello
