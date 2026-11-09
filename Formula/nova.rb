class Nova < Formula
  desc "A fast, customizable zsh prompt renderer."
  homepage "https://github.com/meltin/nova"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/meltin/nova/releases/download/v0.5.0/nova-aarch64-apple-darwin.tar.xz"
      sha256 "940f6b0fe423141364383a099b8ca77ce99cd8816283338e72e364ea9afc7792"
    end
    if Hardware::CPU.intel?
      url "https://github.com/meltin/nova/releases/download/v0.5.0/nova-x86_64-apple-darwin.tar.xz"
      sha256 "335006ccce5f0fb9f93de3033508334cc9400c10d3b6e4d1b626efb9770e80ac"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/meltin/nova/releases/download/v0.5.0/nova-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6bc8bdac86a7818409fb51c5aab86c05c0eb4a4b8e53d474a8afc688dcc8c7c6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/meltin/nova/releases/download/v0.5.0/nova-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7aa04add64d1247a66f3324850165ff69533a9f1033a3030111c5a1cfeb69d48"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "nova"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "nova"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "nova"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "nova"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
