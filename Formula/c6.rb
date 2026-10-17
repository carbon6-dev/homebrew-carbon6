class C6 < Formula
  desc "carbon6 command line: run and follow agent sessions through a carbon6 head"
  homepage "https://github.com/carbon6-dev/carbon6"
  version "0.3.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_arm do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.1/c6-0.3.1-darwin-arm64.tar.gz"
    sha256 "60748f1a26686026982b5064f90894aa2c663aea2dec0827cd7726653b43c3f4"
  end
  on_intel do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.1/c6-0.3.1-darwin-x86_64.tar.gz"
    sha256 "1464d9e75befff0046dfeb4c52dd87bb89776f00d71f2cb709ea14040b123341"
  end

  bottle do
    root_url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.1"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4fc8f64b0fb5b16e824c177ec17349b15c46deaf901fd849e11c141c47a770c5"
    sha256 cellar: :any_skip_relocation, big_sur: "7552f6f8d8b21f3f0c293affaa43b84d08cfe65e2917c0cbed5b71350ffb344b"
  end

  depends_on :macos

  def install
    bin.install "c6"
  end

  def caveats
    <<~EOS
      Sign in once with a token from the head (Settings → Sign-in, or `c6h api-token`):
        c6 login <url> --token <token>
    EOS
  end

  test do
    assert_match "c6", shell_output("#{bin}/c6 --version")
  end
end
