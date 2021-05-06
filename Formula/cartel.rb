require_relative "lib/private_strategy"

class Cartel < Formula
  desc "Local development service orchestrator"
  homepage "https://github.com/xdrop/cartel"
  url "https://github.com/xdrop/cartel/archive/0.8.1-beta.tar.gz"
  sha256 "662e4a7005d75b1460a4f1e7b2f350bd7cfd0e09e98f1fdbc9bc7e5ec75135b2"

  bottle do
    root_url "https://github.com/xdrop/cartel/releases/download/0.8.1-beta"
    sha256 cellar: :any_skip_relocation, mojave:   "31af9a7642ec27f521d87e1507a465313f13ce657985004a3f12652ef74e373a"
    sha256 cellar: :any_skip_relocation, catalina: "31af9a7642ec27f521d87e1507a465313f13ce657985004a3f12652ef74e373a"
    sha256 cellar: :any_skip_relocation, big_sur:  "31af9a7642ec27f521d87e1507a465313f13ce657985004a3f12652ef74e373a"
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
