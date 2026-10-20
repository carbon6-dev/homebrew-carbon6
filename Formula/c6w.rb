class C6w < Formula
  desc "carbon6 worker: runs agent sessions on this Mac for a carbon6 head"
  homepage "https://github.com/carbon6-dev/carbon6"
  version "0.3.7"
  license any_of: ["MIT", "Apache-2.0"]

  on_arm do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.7/c6w-0.3.7-darwin-arm64.tar.gz"
    sha256 "18ff213b11d4938aa24c2280c2d31a2133651627894fef8e61bda14a96b2dadd"
  end
  on_intel do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.7/c6w-0.3.7-darwin-x86_64.tar.gz"
    sha256 "360398f58ef499ad706c7e43f57e4b1571e0eb7b6e5ddc987ec3640da9631715"
  end

  bottle do
    root_url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.7"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b131cc23645a0bb9a8d20c77f7f0c8fa2bd54925a7788f1937f4c38d07a5cd9a"
    sha256 cellar: :any_skip_relocation, big_sur: "e80cb5969c0611a3507ed48cfdbae4ab7bca7e5f7f603b019c19313f9ff2c68b"
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
