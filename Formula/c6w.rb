class C6w < Formula
  desc "carbon6 worker: runs agent sessions on this Mac for a carbon6 head"
  homepage "https://github.com/carbon6-dev/carbon6"
  version "0.3.10"
  license any_of: ["MIT", "Apache-2.0"]

  on_arm do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.10/c6w-0.3.10-darwin-arm64.tar.gz"
    sha256 "847883c530749fdaf7803b6065129bc2c54c1d971bc0e96fda740279dcd69f35"
  end

  bottle do
    root_url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.10"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e01a51d965f3d62ca1b9e6bf9638a732a5c80e7486f4efb06ad31181957a4cba"
  end

  depends_on arch: :arm64
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
