class C6 < Formula
  desc "carbon6 command line: run and follow agent sessions through a carbon6 head"
  homepage "https://github.com/carbon6-dev/carbon6"
  version "0.3.8"
  license any_of: ["MIT", "Apache-2.0"]

  on_arm do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.8/c6-0.3.8-darwin-arm64.tar.gz"
    sha256 "e5ea945df816906a691411ccae5e72ef6879987ff633e406c6acbae1928422c1"
  end
  on_intel do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.8/c6-0.3.8-darwin-x86_64.tar.gz"
    sha256 "e18b83525ad240af0318b74c399bfee42c8cffe85f7d4561e6f5a9e99811b07d"
  end

  bottle do
    root_url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.8"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4257cab9cc1cd6ef5096e3ec2768059afab92e3bd78fb2c20fc9c82d966dec57"
    sha256 cellar: :any_skip_relocation, big_sur: "eb63947c315f61d01c49c6b5d7f743b04bfb4f9124b50c5edc0427046ae21f81"
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
