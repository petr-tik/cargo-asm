#!/usr/bin/env bash

set -ex

: ${TARGET?"The TARGET environment variable must be set."}

export RUST_TEST_THREADS=1
export RUST_BACKTRACE=1

rustup component add rust-src

cargo build --release --target=$TARGET
cargo test --release --target=$TARGET -- --nocapture

cargo run --bin cargo-asm -- asm --manifest-path cargo-asm-test/lib_crate lib_crate::sum_array --rust --debug-mode
cargo run --bin cargo-llvm-ir -- llvm-ir --manifest-path cargo-asm-test/lib_crate lib_crate::sum_array --debug-mode
