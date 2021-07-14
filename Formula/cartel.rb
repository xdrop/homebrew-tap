require_relative "lib/private_strategy"

class Cartel < Formula
  desc "Local development service orchestrator"
  homepage "https://github.com/xdrop/cartel"
  url "https://github.com/xdrop/cartel/archive/0.10.2-beta.tar.gz"
  sha256 "5ffe4f1d3ce918a10d7ef6dcf062bb466169732c9d910df5c5ccc8ec4361d363"

  bottle do
    root_url "https://github.com/xdrop/cartel/releases/download/0.10.2-beta"
    sha256 cellar: :any_skip_relocation, mojave: "3c56ac924e85af093fd818fc190ab7feaf24fcf60c26b6e80e0f6eae8f87493d"
    sha256 cellar: :any_skip_relocation, catalina: "3c56ac924e85af093fd818fc190ab7feaf24fcf60c26b6e80e0f6eae8f87493d"
    sha256 cellar: :any_skip_relocation, big_sur: "3c56ac924e85af093fd818fc190ab7feaf24fcf60c26b6e80e0f6eae8f87493d"
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
