class C6w < Formula
  desc "carbon6 worker: runs agent sessions on this Mac for a carbon6 head"
  homepage "https://github.com/carbon6-dev/carbon6"
  version "0.3.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_arm do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.1/c6w-0.3.1-darwin-arm64.tar.gz"
    sha256 "3ed340e30beb1a547ec349183c09005e3abb5bb8edeea1307ce97430915e619a"
  end
  on_intel do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.1/c6w-0.3.1-darwin-x86_64.tar.gz"
    sha256 "c2ae9b9d98ebebcb35dfff389b4b2c6bcd42774cf919c605bf2637ca0e65e76f"
  end

  bottle do
    root_url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.1"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "041bd733654f14a5c73ad815be9f59d90dab9ca58634a000ea265bed239c3418"
    sha256 cellar: :any_skip_relocation, big_sur: "83ec1de407c4ea46d115e47bcd31f755ef0276aebcb8d860cf37bf55cc8c1bae"
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
