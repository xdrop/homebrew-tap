require_relative "lib/private_strategy"

class Cartel < Formula
    desc "Local development service orchestrator"
    homepage "https://github.com/xdrop/cartel"
    url "https://github.com/xdrop/cartel/archive/0.4.2-alpha.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
    sha256 "34c611caca9160d470e14cb927e6736437a0d34780ab79d0b51b9a1832d9b13e"

    depends_on "rust-nightly" => :build

    bottle do
        root_url "https://github.com/xdrop/cartel/releases/download/0.4.2-alpha", :using => GitHubPrivateRepositoryBottleDownloadStrategy
        cellar :any_skip_relocation
        sha256 "0c473b0426b37b234ba2f98df1ee2a2d095209f3481ee152a572d675e6132c17" => :mojave
        sha256 "0c473b0426b37b234ba2f98df1ee2a2d095209f3481ee152a572d675e6132c17" => :catalina
        sha256 "0c473b0426b37b234ba2f98df1ee2a2d095209f3481ee152a572d675e6132c17" => :big_sur
    end

    def install
        system "cargo", "build", "--release", "--all"
        bin.install "target/release/client" => "cartel"
        bin.install "target/release/daemon" => "cartel-daemon"
    end

    plist_options manual: "cartel-daemon"

    def plist
        <<~EOS
          <?xml version="1.0" encoding="UTF-8"?>
          <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
          <plist version="1.0">
            <dict>
              <key>Label</key>
              <string>#{plist_name}</string>
              <key>RunAtLoad</key>
              <true/>
              <key>KeepAlive</key>
              <false/>
              <key>ProgramArguments</key>
              <array>
                  <string>#{opt_bin}/cartel-daemon</string>
              </array>
              <key>WorkingDirectory</key>
              <string>#{HOMEBREW_PREFIX}</string>
            </dict>
          </plist>
        EOS
      end

end
