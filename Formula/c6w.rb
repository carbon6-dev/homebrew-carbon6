class C6w < Formula
  desc "carbon6 worker: runs agent sessions on this Mac for a carbon6 head"
  homepage "https://github.com/carbon6-dev/carbon6"
  version "0.3.9"
  license any_of: ["MIT", "Apache-2.0"]

  on_arm do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.9/c6w-0.3.9-darwin-arm64.tar.gz"
    sha256 "1e5ab32a7b216af7ef105aa79a5b1c37d807b07f3d186657a594af0591685463"
  end
  on_intel do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.9/c6w-0.3.9-darwin-x86_64.tar.gz"
    sha256 "6038f0519c9a8aa674543291d37bd4ac9e281c9c3e02fac181f54642e2baf748"
  end

  bottle do
    root_url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.9"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4ade6a7f3a2a61acd8873200a5f75ccba8f6a3cfeaedbcf207e40cccc4ae05f6"
    sha256 cellar: :any_skip_relocation, big_sur: "73a130afb83e5f74ec12dda6721f680b79a909a876a0a876324754ceafa60bb5"
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
