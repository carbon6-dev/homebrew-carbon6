class C6 < Formula
  desc "carbon6 command line: run and follow agent sessions through a carbon6 head"
  homepage "https://github.com/carbon6-dev/carbon6"
  version "0.3.3"
  license any_of: ["MIT", "Apache-2.0"]

  on_arm do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.3/c6-0.3.3-darwin-arm64.tar.gz"
    sha256 "d3f8ccd7540a58fef13e02e8c67143bcd07a2ea381187153397be9a0ae0a6852"
  end
  on_intel do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.3/c6-0.3.3-darwin-x86_64.tar.gz"
    sha256 "64c73f661c71284a8aeca9e17b40642878c0fccecaac855df3ae4ec0f1e7bc4f"
  end

  bottle do
    root_url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.3"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8581f1c282901acd553fdce26762c0698a3cdc1c5e8fedeff4dfe37f8aa27c5f"
    sha256 cellar: :any_skip_relocation, big_sur: "79aec6ea2dec61c7ab35be92b4a422a269f162b3fb42a49204daa8a63cccc395"
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
