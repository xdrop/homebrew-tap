require_relative "lib/private_strategy"

class Cartel < Formula
  desc "Local development service orchestrator"
  homepage "https://github.com/xdrop/cartel"
  url "https://github.com/xdrop/cartel/archive/0.9.3-beta.tar.gz"
  sha256 "054da71652a451656630e4f43026a2d5c8079a3697cedc83d994afd902133f2d"

  bottle do
    root_url "https://github.com/xdrop/cartel/releases/download/0.9.3-beta"
    sha256 cellar: :any_skip_relocation, mojave:   "dd499df18206325b2c92290390f07ce9ea5abc21247245f6f5962f12b24a09f2"
    sha256 cellar: :any_skip_relocation, catalina: "dd499df18206325b2c92290390f07ce9ea5abc21247245f6f5962f12b24a09f2"
    sha256 cellar: :any_skip_relocation, big_sur:  "dd499df18206325b2c92290390f07ce9ea5abc21247245f6f5962f12b24a09f2"
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
