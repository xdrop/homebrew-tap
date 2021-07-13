require_relative "lib/private_strategy"

class Cartel < Formula
  desc "Local development service orchestrator"
  homepage "https://github.com/xdrop/cartel"
  url "https://github.com/xdrop/cartel/archive/0.10.1-beta.tar.gz"
  sha256 "dbf96980e1596d2ebe57e88d8aefd95f8d24d71369d516bd3f64d1661f0d3d2a"

  bottle do
    root_url "https://github.com/xdrop/cartel/releases/download/0.10.1-beta"
    sha256 cellar: :any_skip_relocation, mojave:   "ea87beada6da687147ee7a9bbf12c79c4805012ed8fb0ea1848a097a64b2c67b"
    sha256 cellar: :any_skip_relocation, catalina: "ea87beada6da687147ee7a9bbf12c79c4805012ed8fb0ea1848a097a64b2c67b"
    sha256 cellar: :any_skip_relocation, big_sur:  "ea87beada6da687147ee7a9bbf12c79c4805012ed8fb0ea1848a097a64b2c67b"
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
