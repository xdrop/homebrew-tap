require_relative "lib/private_strategy"

class Cartel < Formula
  desc "Local development service orchestrator"
  homepage "https://github.com/xdrop/cartel"
  url "https://github.com/xdrop/cartel/archive/0.9.4-beta.tar.gz"
  sha256 "45582b4c9762917f94559a7d175f1e7186f2cbdd5b839959f77eedc96324b31f"

  bottle do
    root_url "https://github.com/xdrop/cartel/releases/download/0.9.4-beta"
    sha256 cellar: :any_skip_relocation, mojave:   "9530da1cae6ecdb27bdd88e5de17e6b5304b06af6e3a66d74bfbc4f99a5eec02"
    sha256 cellar: :any_skip_relocation, catalina: "9530da1cae6ecdb27bdd88e5de17e6b5304b06af6e3a66d74bfbc4f99a5eec02"
    sha256 cellar: :any_skip_relocation, big_sur:  "9530da1cae6ecdb27bdd88e5de17e6b5304b06af6e3a66d74bfbc4f99a5eec02"
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
