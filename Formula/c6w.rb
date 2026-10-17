class C6w < Formula
  desc "carbon6 worker: runs agent sessions on this Mac for a carbon6 head"
  homepage "https://github.com/carbon6-dev/carbon6"
  version "0.3.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_arm do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.2/c6w-0.3.2-darwin-arm64.tar.gz"
    sha256 "b7bcbc3b60a45fd3b0182a6e9e529d5232dd11ab33394c74be3d4a310f8c07f0"
  end
  on_intel do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.2/c6w-0.3.2-darwin-x86_64.tar.gz"
    sha256 "57868d5435e57f85721254681eaf94cbdcc98afd3256062ce4d4805f3ed88fee"
  end

  bottle do
    root_url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.2"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "84e3e7010af3394f89d4de9e9d22637a2da49568b09833645229de849aa936d2"
    sha256 cellar: :any_skip_relocation, big_sur: "a905f654aee23b83803f292b32e31078dbd6448ebb130faddab99e2b66ea5209"
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
