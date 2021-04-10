require_relative "lib/private_strategy"

class Cartel < Formula
  desc "Local development service orchestrator"
  homepage "https://github.com/xdrop/cartel"
  url "https://github.com/xdrop/cartel/archive/0.7.4-beta.tar.gz"
  sha256 "a693a719737f00e4860999ef614cb4c1747730386c6f49f57f28fb9ec71b4c92"

  bottle do
    root_url "https://github.com/xdrop/cartel/releases/download/0.7.4-beta"
    sha256 cellar: :any_skip_relocation, mojave:   "95406d4ecb607442f6f89a98f883a7e31e384bf39fb987e94e8ec48bb6d6a748"
    sha256 cellar: :any_skip_relocation, catalina: "95406d4ecb607442f6f89a98f883a7e31e384bf39fb987e94e8ec48bb6d6a748"
    sha256 cellar: :any_skip_relocation, big_sur:  "95406d4ecb607442f6f89a98f883a7e31e384bf39fb987e94e8ec48bb6d6a748"
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
