require_relative "lib/private_strategy"

class Cartel < Formula
  desc "Local development service orchestrator"
  homepage "https://github.com/xdrop/cartel"
  url "https://github.com/xdrop/cartel/archive/0.9.2-beta.tar.gz"
  sha256 "9ac4c4f6e2f9fb261e3f6594033d9f25c8964c6dc06025e3130f42dcb9d91977"

  bottle do
    root_url "https://github.com/xdrop/cartel/releases/download/0.9.2-beta"
    sha256 cellar: :any_skip_relocation, mojave:   "cd56c55aca6d2881a8ffc3be4a961a67143f2e7fd6fb64968ab1569f063d5952"
    sha256 cellar: :any_skip_relocation, catalina: "cd56c55aca6d2881a8ffc3be4a961a67143f2e7fd6fb64968ab1569f063d5952"
    sha256 cellar: :any_skip_relocation, big_sur:  "cd56c55aca6d2881a8ffc3be4a961a67143f2e7fd6fb64968ab1569f063d5952"
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
