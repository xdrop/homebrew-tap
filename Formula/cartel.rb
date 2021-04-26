require_relative "lib/private_strategy"

class Cartel < Formula
  desc "Local development service orchestrator"
  homepage "https://github.com/xdrop/cartel"
  url "https://github.com/xdrop/cartel/archive/0.8.0-beta.tar.gz"
  sha256 "b6b5e766471d6fd3da4af70c796e6b9909e9b7e315ece5fe9565dace2dacd81c"

  bottle do
    root_url "https://github.com/xdrop/cartel/releases/download/0.8.0-beta"
    sha256 cellar: :any_skip_relocation, mojave:   "f09027e4aa28c0d673884ae0e0404d2150d9700819294e7865281fee7c95f4b1"
    sha256 cellar: :any_skip_relocation, catalina: "f09027e4aa28c0d673884ae0e0404d2150d9700819294e7865281fee7c95f4b1"
    sha256 cellar: :any_skip_relocation, big_sur:  "f09027e4aa28c0d673884ae0e0404d2150d9700819294e7865281fee7c95f4b1"
  end

  depends_on "rust-nightly" => :build

  def install
    system "cargo", "build", "--release", "--all"
    bin.install "target/release/client" => "cartel"
    bin.install "target/release/daemon" => "cartel-daemon"
    prefix.install "launch-daemon.sh"
  end

  def caveats
    <<~EOS
      Add the following line to your ~/.bash_profile or ~/.zshrc file:
        [ -f #{opt_prefix}/launch-daemon.sh ] && . #{opt_prefix}/launch-daemon.sh
      Restart your terminal for the settings to take effect.
    EOS
  end
end
