require_relative "lib/private_strategy"

class Cartel < Formula
  desc "Local development service orchestrator"
  homepage "https://github.com/xdrop/cartel"
  url "https://github.com/xdrop/cartel/archive/0.11.1-beta.tar.gz"
  sha256 "5a8f1cb2d1b31c9fd735a847a4b193a0aba3b2da813bbcee40029a83e07ed833"

  bottle do
    root_url "https://github.com/xdrop/cartel/releases/download/0.11.1-beta"
    sha256 cellar: :any_skip_relocation, mojave: "54527b4c5d8d9a7694df2b8681dfb982cc3bd5fe4c7de7c018e36db14484e1a8"
    sha256 cellar: :any_skip_relocation, catalina: "54527b4c5d8d9a7694df2b8681dfb982cc3bd5fe4c7de7c018e36db14484e1a8"
    sha256 cellar: :any_skip_relocation, big_sur: "54527b4c5d8d9a7694df2b8681dfb982cc3bd5fe4c7de7c018e36db14484e1a8"
  end

  depends_on "rust-nightly" => :build

  def install
    system "cargo", "build", "--release", "--all"
    bin.install "target/release/client" => "cartel"
    bin.install "target/release/daemon" => "cartel-daemon"
    prefix.install "launch-daemon.sh"
  end

  def post_install
    system "pkill", "-i", "cartel-daemon"
  end

  def caveats
    <<~EOS
      Add the following line to your ~/.bash_profile or ~/.zshrc file:
        [ -f #{opt_prefix}/launch-daemon.sh ] && . #{opt_prefix}/launch-daemon.sh
      Restart your terminal for the settings to take effect.
    EOS
  end
end
