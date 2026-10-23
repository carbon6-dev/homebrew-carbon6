class C6 < Formula
  desc "carbon6 command line: run and follow agent sessions through a carbon6 head"
  homepage "https://github.com/carbon6-dev/carbon6"
  version "0.3.9"
  license any_of: ["MIT", "Apache-2.0"]

  on_arm do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.9/c6-0.3.9-darwin-arm64.tar.gz"
    sha256 "9486c7bae44f55f3257e4fa61934a99ff600858f8f10be591f10a0929923d666"
  end
  on_intel do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.9/c6-0.3.9-darwin-x86_64.tar.gz"
    sha256 "2da1da215152eda2b646a872a70322ff4dedf0a72b40ba7ed7069f273cdd65ed"
  end

  bottle do
    root_url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.9"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b4667b6306a766d011cdb0d0c221b174b4e1dc3cde39d9da2ccf6dc646471a0b"
    sha256 cellar: :any_skip_relocation, big_sur: "49efb888d179dc5c98d39027044030c282e46fc199b4d159d99779f0166deefe"
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
