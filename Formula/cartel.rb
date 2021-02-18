require_relative "lib/private_strategy"

class Cartel < Formula
    desc "Local development service orchestrator"
    homepage "https://github.com/xdrop/cartel"
    url "https://github.com/xdrop/cartel/archive/0.6.0-beta.tar.gz"
    sha256 "dfc511e2c3cd14f00334dcd702f8c3b900ee7cbf619b16c1e6fec514fe32840c"

    depends_on "rust-nightly" => :build

    bottle do
        root_url "https://github.com/xdrop/cartel/releases/download/0.6.0-beta"
        cellar :any_skip_relocation
        sha256 "e14b684c3c55d61f3d10ae4880973180c3a9a8f6f80fdbbae4ccacaf966debb8" => :mojave
        sha256 "e14b684c3c55d61f3d10ae4880973180c3a9a8f6f80fdbbae4ccacaf966debb8" => :catalina
        sha256 "e14b684c3c55d61f3d10ae4880973180c3a9a8f6f80fdbbae4ccacaf966debb8" => :big_sur
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
