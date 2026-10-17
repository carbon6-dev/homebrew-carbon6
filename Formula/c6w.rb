class C6w < Formula
  desc "carbon6 worker: runs agent sessions on this Mac for a carbon6 head"
  homepage "https://github.com/carbon6-dev/carbon6"
  version "0.3.3"
  license any_of: ["MIT", "Apache-2.0"]

  on_arm do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.3/c6w-0.3.3-darwin-arm64.tar.gz"
    sha256 "00d0ba76c4ced0592481a6c488019b44abc5ac439815396ebb52f2fc7e1a09dc"
  end
  on_intel do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.3/c6w-0.3.3-darwin-x86_64.tar.gz"
    sha256 "dc7f43bff0361333e5c2eddcae54fc7ebb39b84fc101e9799b1e8342e2d91d31"
  end

  bottle do
    root_url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.3"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "bc047d91356439688f17af39745dc54a606bb76a0c1c3bad2e293829dde9337e"
    sha256 cellar: :any_skip_relocation, big_sur: "4cacb9e75feab3f3318cf7093abe8ac0c3468c37110e17f40bffbc6382155f3a"
  end

  depends_on :macos

  def install
    bin.install "c6w"
  end

  post_install_steps do
    mkdir_p "log", base: :var
  end

  # Runs as you, through a login shell so sessions get your PATH.
  service do
    run ["/bin/zsh", "-lc", "exec #{opt_bin}/c6w run"]
    keep_alive successful_exit: false
    environment_variables NO_COLOR: "1"
    log_path var/"log/c6w.log"
    error_log_path var/"log/c6w.log"
  end

  def caveats
    <<~EOS
      Enroll with a token from the head's Workers page, then start the worker:
        c6w enroll <token>
        brew services start c6w   (log: #{var}/log/c6w.log)
    EOS
  end

  test do
    assert_match "c6w", shell_output("#{bin}/c6w --version")
  end
end
