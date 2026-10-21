class C6w < Formula
  desc "carbon6 worker: runs agent sessions on this Mac for a carbon6 head"
  homepage "https://github.com/carbon6-dev/carbon6"
  version "0.3.8"
  license any_of: ["MIT", "Apache-2.0"]

  on_arm do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.8/c6w-0.3.8-darwin-arm64.tar.gz"
    sha256 "75027414d840636be8d33397b00674e875d4ea18f9d8d7360084d77c0580985a"
  end
  on_intel do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.8/c6w-0.3.8-darwin-x86_64.tar.gz"
    sha256 "f732492db7360dc029615163d9e039fbdccbac4633f15455c7217c39d790d35c"
  end

  bottle do
    root_url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.8"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d06d49d6eed530573a67215fe23e7ad902b879de2207c57b27d6d4530cf67dff"
    sha256 cellar: :any_skip_relocation, big_sur: "98f6dc4a9266ee500afefae9805dc87fa0e48203d8caf8492777d3d3b08b4ff1"
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
