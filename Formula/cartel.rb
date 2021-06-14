require_relative "lib/private_strategy"

class Cartel < Formula
  desc "Local development service orchestrator"
  homepage "https://github.com/xdrop/cartel"
  url "https://github.com/xdrop/cartel/archive/0.9.0-beta.tar.gz"
  sha256 "87fae5158be952d0e13f3c8aece41105ddd60deedffc811eac4ebdd0e7295791"

  bottle do
    root_url "https://github.com/xdrop/cartel/releases/download/0.9.0-beta"
    sha256 cellar: :any_skip_relocation, mojave:   "b9587a8fc8f9c05e5e9dcdeba53d6127c367edc26d62c8af3bd21099b4ec6c6d"
    sha256 cellar: :any_skip_relocation, catalina: "b9587a8fc8f9c05e5e9dcdeba53d6127c367edc26d62c8af3bd21099b4ec6c6d"
    sha256 cellar: :any_skip_relocation, big_sur:  "b9587a8fc8f9c05e5e9dcdeba53d6127c367edc26d62c8af3bd21099b4ec6c6d"
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
