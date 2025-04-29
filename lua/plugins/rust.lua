return {
  { "simrat39/rust-tools.nvim", ft = { "rust" }, config = true }, -- Load for Rust files
  { "saecki/crates.nvim", event = { "BufRead Cargo.toml" }, config = true }, -- Load when Cargo.toml is read
}
