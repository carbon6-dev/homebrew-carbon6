class C6h < Formula
  desc "carbon6 head: manages workers and serves the web UI"
  homepage "https://github.com/carbon6-dev/carbon6"
  version "0.3.3"
  license any_of: ["MIT", "Apache-2.0"]

  on_arm do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.3/c6h-0.3.3-darwin-arm64.tar.gz"
    sha256 "ac76911653e5e7011a07d96b6797fc64fc4b69de1636bbcbce7dcffb42932156"
  end
  on_intel do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.3/c6h-0.3.3-darwin-x86_64.tar.gz"
    sha256 "dcb9dc708b61d131eee2de3ccf5b054d24126487c40348991a908a8a2877afbc"
  end

  bottle do
    root_url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.3"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4c2cba3bb0031b59145a10c2104f4a3451db6b705f6111a4263869b1cbba2f89"
    sha256 cellar: :any_skip_relocation, big_sur: "b599bfc80e27ef203e08d8db99496cc52f3efa2030e2c5536b34676111de484a"
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
