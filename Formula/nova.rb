class Nova < Formula
  desc "A fast, customizable zsh prompt renderer."
  homepage "https://github.com/unmett/nova"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/unmett/nova/releases/download/v0.4.0/nova-aarch64-apple-darwin.tar.xz"
      sha256 "6b6687e02f26322a6cca34d18348530ef0be2dca46f0f1d04384d68278458763"
    end
    if Hardware::CPU.intel?
      url "https://github.com/unmett/nova/releases/download/v0.4.0/nova-x86_64-apple-darwin.tar.xz"
      sha256 "a20af7ede2577ed41e663624099fa21ec7baa50ce10d23c70fd22b06e2c38d13"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/unmett/nova/releases/download/v0.4.0/nova-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "16e30820d456121ec5c9766ee6822ece1b7577caae0bf94dab57c6452b71b5a5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/unmett/nova/releases/download/v0.4.0/nova-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "36b6b100d41c18a5d7703fb928e24626a9fdaee211cb4b29d916fd4e47ffae82"
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
