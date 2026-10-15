class C6h < Formula
  desc "carbon6 head: manages workers and serves the web UI"
  homepage "https://github.com/carbon6-dev/carbon6"
  version "0.2.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_arm do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.2.2/c6h-0.2.2-darwin-arm64.tar.gz"
    sha256 "813d17deccc83cec2cc1bc339a83dc52455316f9ed2c62a1cbd5395f8e8624e6"
  end
  on_intel do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.2.2/c6h-0.2.2-darwin-x86_64.tar.gz"
    sha256 "133351062d05686b90db44ff4ae1349129be622648c3010c2739b709969b6ecf"
  end

  bottle do
    root_url "https://github.com/carbon6-dev/carbon6/releases/download/v0.2.2"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d90bc2f5e828f236c84a27fdc4dd4cd074b89f7da33e6a1b6411968e997b0fee"
    sha256 cellar: :any_skip_relocation, big_sur: "c48b25cc94fb0e283a4d6186f60ccc26476c009307740e0b4f91616d9ae7b050"
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
