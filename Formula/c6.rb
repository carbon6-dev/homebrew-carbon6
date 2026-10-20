class C6 < Formula
  desc "carbon6 command line: run and follow agent sessions through a carbon6 head"
  homepage "https://github.com/carbon6-dev/carbon6"
  version "0.3.7"
  license any_of: ["MIT", "Apache-2.0"]

  on_arm do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.7/c6-0.3.7-darwin-arm64.tar.gz"
    sha256 "4757113869901fb9610c3a1cea9255c04e3981a8771b578dc0ee8496a8a988b0"
  end
  on_intel do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.7/c6-0.3.7-darwin-x86_64.tar.gz"
    sha256 "8ccba2be27626ca3a44a824819facb1a9fb92beba77d0afc0396d5dc69ccaf56"
  end

  bottle do
    root_url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.7"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "499702d715599e6359a4815cbafb2be8da41e7266e06c8ad37c047e758a99970"
    sha256 cellar: :any_skip_relocation, big_sur: "24cf8d0ad9b065c27882e6cdd5f202100ff361e8a42e4ed7ad6f38959dfd9f09"
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
