class C6 < Formula
  desc "carbon6 command line: run and follow agent sessions through a carbon6 head"
  homepage "https://github.com/carbon6-dev/carbon6"
  version "0.2.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_arm do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.2.2/c6-0.2.2-darwin-arm64.tar.gz"
    sha256 "1fa84e4ac8da00b7ab4bc9ec1a2992322ae8c3561c7c68888bf96e68e2cddd4c"
  end
  on_intel do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.2.2/c6-0.2.2-darwin-x86_64.tar.gz"
    sha256 "76e683df6125f95a5179e88d205f5ab7ae2a6d5b39860ce646f8f627dcd2f8a6"
  end

  bottle do
    root_url "https://github.com/carbon6-dev/carbon6/releases/download/v0.2.2"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "9cf158a2d2a8a16acb26beb1785bc09bc28a7e65ed9cdc72266d54b1c83e074a"
    sha256 cellar: :any_skip_relocation, big_sur: "15f0e8a811842c89ed510ef191da8e091673d5aa998cffed403a5f5fcd590886"
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
