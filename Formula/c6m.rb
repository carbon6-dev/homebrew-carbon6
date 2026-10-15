class C6m < Formula
  desc "carbon6 memex: the carbon6 knowledge store, attached to a carbon6 head"
  homepage "https://github.com/carbon6-dev/carbon6"
  version "0.2.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_arm do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.2.2/c6m-0.2.2-darwin-arm64.tar.gz"
    sha256 "8bd06616038d9306d78d289c0cb15f07931499a7bae431b2364c78edc14d5436"
  end
  on_intel do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.2.2/c6m-0.2.2-darwin-x86_64.tar.gz"
    sha256 "c74153f7dfe3e5598fa4df64c75289ad1bf4675c06f1e124b9b92acb0e749df1"
  end

  bottle do
    root_url "https://github.com/carbon6-dev/carbon6/releases/download/v0.2.2"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d324f115d14ba4769e0f5285ec1371b186b5db5be61178d920f65876ab348e95"
    sha256 cellar: :any_skip_relocation, big_sur: "8408eb23a462f13665952975827ba0fdee049200f13ab0bcfbee79521ec05acd"
  end

  depends_on :macos

  def install
    bin.install "c6m"
  end

  post_install_steps do
    mkdir_p "log", base: :var
  end

  service do
    run [opt_bin/"c6m", "run"]
    keep_alive successful_exit: false
    environment_variables NO_COLOR: "1", PATH: std_service_path_env
    log_path var/"log/c6m.log"
    error_log_path var/"log/c6m.log"
  end

  def caveats
    <<~EOS
      Enroll with a token from the head's Settings → Memex, then start the memex:
        c6m enroll <token>
        brew services start c6m   (log: #{var}/log/c6m.log)
      It finds ffmpeg (brew install ffmpeg) for video and audio.
    EOS
  end

  test do
    assert_match "c6m", shell_output("#{bin}/c6m --version")
  end
end
