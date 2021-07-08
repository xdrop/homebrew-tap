require_relative "lib/private_strategy"

class Cartel < Formula
  desc "Local development service orchestrator"
  homepage "https://github.com/xdrop/cartel"
  url "https://github.com/xdrop/cartel/archive/0.9.5-beta.tar.gz"
  sha256 "f7dd2942c2ea0ceb20327df129b7081ddd889b7d228ea3e5cb31b9dece520764"

  bottle do
    root_url "https://github.com/xdrop/cartel/releases/download/0.9.5-beta"
    sha256 cellar: :any_skip_relocation, mojave:   "b4e817d989658827ff73b1031c9fd0b89714b4e6b40c7ed2db8b87340c781980"
    sha256 cellar: :any_skip_relocation, catalina: "b4e817d989658827ff73b1031c9fd0b89714b4e6b40c7ed2db8b87340c781980"
    sha256 cellar: :any_skip_relocation, big_sur:  "b4e817d989658827ff73b1031c9fd0b89714b4e6b40c7ed2db8b87340c781980"
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
