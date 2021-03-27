require_relative "lib/private_strategy"

class Cartel < Formula
    desc "Local development service orchestrator"
    homepage "https://github.com/xdrop/cartel"
    url "https://github.com/xdrop/cartel/archive/0.7.0-beta.tar.gz"
    sha256 "bdb7ce2d80af74a73452c2523d40f7a7bce6fc3d2def7f4915aa2486d1dc05d9"

    depends_on "rust-nightly" => :build

    bottle do
        root_url "https://github.com/xdrop/cartel/releases/download/0.7.0-beta"
        cellar :any_skip_relocation
        sha256 "2d8cb2d247528035de0d0403b80dfca0d0115d16f150263bbeb8504225ccc33f" => :mojave
        sha256 "2d8cb2d247528035de0d0403b80dfca0d0115d16f150263bbeb8504225ccc33f" => :catalina
        sha256 "2d8cb2d247528035de0d0403b80dfca0d0115d16f150263bbeb8504225ccc33f" => :big_sur
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
              <true/>
              <key>ProgramArguments</key>
              <array>
                  <string>#{opt_bin}/cartel-daemon</string>
                  <string>--shell</string>
                  <string>#{ENV["SHELL"]}</string>
              </array>
              <key>WorkingDirectory</key>
              <string>#{HOMEBREW_PREFIX}</string>
              <key>SessionCreate</key>
              <true/>
            </dict>
          </plist>
        EOS
      end

end
