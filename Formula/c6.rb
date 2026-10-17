class C6 < Formula
  desc "carbon6 command line: run and follow agent sessions through a carbon6 head"
  homepage "https://github.com/carbon6-dev/carbon6"
  version "0.3.4"
  license any_of: ["MIT", "Apache-2.0"]

  on_arm do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.4/c6-0.3.4-darwin-arm64.tar.gz"
    sha256 "b3c7811330592e29ab9baaea8d1655e76374a2384d273410bef3ace122454a29"
  end
  on_intel do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.4/c6-0.3.4-darwin-x86_64.tar.gz"
    sha256 "c74e282c4ba34ce8ee2f29f27d2039fc1687da6d696d8fe40d7fb9abf21ead44"
  end

  bottle do
    root_url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.4"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "40fb7e2fd22767982eb39fec746521ad36c0288e19b73469a0cddea2f6179ac5"
    sha256 cellar: :any_skip_relocation, big_sur: "6c51a23497884bcd130b6f581f72c87f6a95a6fa774e0bc52e3d8d1839773bef"
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
