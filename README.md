# Simple Hello World Rocket template

This repository contains a simple Hello World Rocket example.

In addition, it contains a Dockerfile for making a release build
docker image, with a statically linked dinary in an alpine base. The
Dockerfile has a separate dependencies layer that only depends on the
Cargo.toml and Cargo.lock.