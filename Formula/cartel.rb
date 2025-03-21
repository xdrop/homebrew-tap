
# this file was autogenerated by publish_release
class Cartel < Formula
    version "0.12.1-beta"
    desc "Local development orchestrator. Process & dependency management to run development playgrounds"
    homepage "https://github.com/xdrop/cartel"
    url "https://github.com/xdrop/cartel/releases/download/0.12.1-beta/cartel-0.12.1-beta.darwin.#{Hardware::CPU.arm? ? "arm64" : "amd64"}.zip"
    sha256 Hardware::CPU.arm? ? "9ef555e494918f92f616b3acc82cede3c5d1434e933cc9338f98bcaf502dbfa9" : "177ecac08abe7bcda0d8a5f1d0424a1d5f546b31257cceaaf8793dc4cabc3747"
    license ""

    def install
        # Install both binaries to the bin directory
        bin.install "cartel"
        bin.install "cartel-daemon"
        prefix.install "launch-daemon.sh"
    end

    test do
        # Test that the binaries exist and are executable
        system bin/"cartel", "--version"
        system bin/"cartel-daemon", "--version"
    end

    def caveats
        <<~EOS
        Add the following line to your ~/.bash_profile or ~/.zshrc file:
            [ -f #{opt_prefix}/launch-daemon.sh ] && . #{opt_prefix}/launch-daemon.sh
        Restart your terminal for the settings to take effect.
        EOS
    end
end
