require_relative "lib/private_strategy"

class Cartel < Formula
  desc "Local development service orchestrator"
  homepage "https://github.com/xdrop/cartel"
  url "https://github.com/xdrop/cartel/archive/0.10.0-beta.tar.gz"
  sha256 "71568601782ddf4159fb53bf9be888f6efe98bc42feafc8cbe6ec3c4ff3f623d"

  bottle do
    root_url "https://github.com/xdrop/cartel/releases/download/0.10.0-beta"
    sha256 cellar: :any_skip_relocation, mojave:   "ce4b01c9da01640cbe67a1d8d9785c21fd2433e55e0839133c2e993aecedd920"
    sha256 cellar: :any_skip_relocation, catalina: "ce4b01c9da01640cbe67a1d8d9785c21fd2433e55e0839133c2e993aecedd920"
    sha256 cellar: :any_skip_relocation, big_sur:  "ce4b01c9da01640cbe67a1d8d9785c21fd2433e55e0839133c2e993aecedd920"
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
