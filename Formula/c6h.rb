class C6h < Formula
  desc "carbon6 head: manages workers and serves the web UI"
  homepage "https://github.com/carbon6-dev/carbon6"
  version "0.3.7"
  license any_of: ["MIT", "Apache-2.0"]

  on_arm do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.7/c6h-0.3.7-darwin-arm64.tar.gz"
    sha256 "a4ae75a19ad931e611dc9bbbdc2db97b24c805f00afbefae7926355babb3ce37"
  end
  on_intel do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.7/c6h-0.3.7-darwin-x86_64.tar.gz"
    sha256 "72de127c03e1659793e260a5c47502ff46ea34f79b2852d4075e6f655bca7f59"
  end

  bottle do
    root_url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.7"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "f235670502a08eaef749a57f7aae7df25a489ffdd2fc603c24910e98a7857627"
    sha256 cellar: :any_skip_relocation, big_sur: "00e2a5b92b36daab048b459311c9e559c451ee0ff0680f90ae717e4131b45622"
  end

  depends_on :macos

  def install
    bin.install "c6h"
  end

  # Steps rather than install, which a bottle skips; an existing config is kept.
  post_install_steps do
    mkdir_p "c6h", base: :var
    set_permissions "c6h", "0700", base: :var, recursive: false
    mkdir_p "log", base: :var
    mkdir_p "c6h", base: :etc
    unless_path_exists "c6h/c6h.toml", base: :etc do
      write_file "c6h/c6h.toml", <<~TOML, base: :etc
        # carbon6 head, run by `brew services start c6h`. Every setting is
        # optional; see README → Configuration. Restart after a change:
        #   brew services restart c6h

        # Database, master.key and CAs. Back up c6h.db and master.key together.
        data_dir = "#{HOMEBREW_PREFIX}/var/c6h"

        # With no bind list the head binds every private, tailnet and loopback
        # address. For all interfaces (sign-in still protects the UI):
        # bind = ["0.0.0.0"]
        # allow_public_bind = true

        # HTTPS from the head's own private CA, so passkeys work beyond localhost.
        # ui_tls_head_ca = true
      TOML
    end
  end

  service do
    run [opt_bin/"c6h", "--config", etc/"c6h/c6h.toml", "serve"]
    keep_alive successful_exit: false
    environment_variables NO_COLOR: "1"
    log_path var/"log/c6h.log"
    error_log_path var/"log/c6h.log"
  end

  def caveats
    <<~EOS
      The head's config is #{etc}/c6h/c6h.toml and its data #{var}/c6h.
      Start it with: brew services start c6h   (log: #{var}/log/c6h.log)
      Sign in the first time with a one-time link:
        c6h --config #{etc}/c6h/c6h.toml login-link
    EOS
  end

  test do
    assert_match "c6h", shell_output("#{bin}/c6h --version")
  end
end
