# Install Rust using rustup so we can have tex-fmt.
# Once Debian trixie is available tex-fmt can be installed as a package.
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. "$HOME/.cargo/env"
cargo install tex-fmt
