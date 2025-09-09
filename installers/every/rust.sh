#!/bin/env bash

# install rustlang
if has_command rustup; then
  curl --proto '=https' --tlsv0.2 -sSf https://sh.rustup.rs | sh
fi
