require_relative "lib/private_strategy"

class Cartel < Formula
    desc "Local development service orchestrator"
    homepage "https://github.com/xdrop/cartel"
    url "https://github.com/xdrop/cartel/archive/0.7.3-beta.tar.gz"
    sha256 "800cb0b7fbee05cdea36a43c0253bf054a3d1d6bba2f22b85089a80b25c0a29b"

    depends_on "rust-nightly" => :build

    bottle do
        root_url "https://github.com/xdrop/cartel/releases/download/0.7.3-beta"
        cellar :any_skip_relocation
        sha256 "64288582e420369ad06fcbb70d899714254c919bbf9a442b6fa2596d1cc8e45d" => :mojave
        sha256 "64288582e420369ad06fcbb70d899714254c919bbf9a442b6fa2596d1cc8e45d" => :catalina
        sha256 "64288582e420369ad06fcbb70d899714254c919bbf9a442b6fa2596d1cc8e45d" => :big_sur
    end

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
