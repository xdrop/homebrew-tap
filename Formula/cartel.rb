require_relative "lib/private_strategy"

class Cartel < Formula
    desc "Local development service orchestrator"
    homepage "https://github.com/xdrop/cartel"
    url "https://github.com/xdrop/cartel/archive/0.5.0-beta.tar.gz", :using => GitHubPrivateRepositoryReleaseDownloadStrategy
    sha256 "25a843b4808d50d2bb88d7a70323691161a2c20fdea01e257a2e9437e09a2f57"

    depends_on "rust-nightly" => :build

    bottle do
        root_url "https://github.com/xdrop/cartel/releases/download/0.5.0-beta", :using => GitHubPrivateRepositoryBottleDownloadStrategy
        cellar :any_skip_relocation
        sha256 "9347e74ec4e6f1141edea37112e70fc9f79ab8736f9668bd8cafdeb8552fe9af" => :mojave
        sha256 "9347e74ec4e6f1141edea37112e70fc9f79ab8736f9668bd8cafdeb8552fe9af" => :catalina
        sha256 "9347e74ec4e6f1141edea37112e70fc9f79ab8736f9668bd8cafdeb8552fe9af" => :big_sur
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
