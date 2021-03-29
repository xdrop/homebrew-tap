require_relative "lib/private_strategy"

class Cartel < Formula
    desc "Local development service orchestrator"
    homepage "https://github.com/xdrop/cartel"
    url "https://github.com/xdrop/cartel/archive/0.7.2-beta.tar.gz"
    sha256 "ec48727ffe5956a925f33f009e06e66d0a2b1e9353749609438faf0599ce053c"

    depends_on "rust-nightly" => :build

    bottle do
        root_url "https://github.com/xdrop/cartel/releases/download/0.7.2-beta"
        cellar :any_skip_relocation
        sha256 "719702bf70cee8129f5420a313aee9c98b787729af3f06c656896d58eb04b5fc" => :mojave
        sha256 "719702bf70cee8129f5420a313aee9c98b787729af3f06c656896d58eb04b5fc" => :catalina
        sha256 "719702bf70cee8129f5420a313aee9c98b787729af3f06c656896d58eb04b5fc" => :big_sur
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
