class C6 < Formula
  desc "carbon6 command line: run and follow agent sessions through a carbon6 head"
  homepage "https://github.com/carbon6-dev/carbon6"
  version "0.3.10"
  license any_of: ["MIT", "Apache-2.0"]

  on_arm do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.10/c6-0.3.10-darwin-arm64.tar.gz"
    sha256 "123c15b20c1049c8cce1ebcfd2638b309cbeb32218b23ae3d9e24b6cbbbde923"
  end

  bottle do
    root_url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.10"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "1b2109de4b329d8e856a9df587691261d19a70db8cd1d33deb9b4fce06e60355"
  end

  depends_on arch: :arm64
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
