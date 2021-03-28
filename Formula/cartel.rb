require_relative "lib/private_strategy"

class Cartel < Formula
    desc "Local development service orchestrator"
    homepage "https://github.com/xdrop/cartel"
    url "https://github.com/xdrop/cartel/archive/0.7.1-beta.tar.gz"
    sha256 "f9a78686f60688444df961407e2713cf372c163797a3b7fb8d414be3e8e80d50"

    depends_on "rust-nightly" => :build

    bottle do
        root_url "https://github.com/xdrop/cartel/releases/download/0.7.1-beta"
        cellar :any_skip_relocation
        sha256 "096b036136d61a2c37694cb0e963442ec10903a4a068e539f50a29d61971f88e" => :mojave
        sha256 "096b036136d61a2c37694cb0e963442ec10903a4a068e539f50a29d61971f88e" => :catalina
        sha256 "096b036136d61a2c37694cb0e963442ec10903a4a068e539f50a29d61971f88e" => :big_sur
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
