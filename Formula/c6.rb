class C6 < Formula
  desc "carbon6 command line: run and follow agent sessions through a carbon6 head"
  homepage "https://github.com/carbon6-dev/carbon6"
  version "0.3.11"
  license any_of: ["MIT", "Apache-2.0"]

  on_arm do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.11/c6-0.3.11-darwin-arm64.tar.gz"
    sha256 "ba8abaf894bec12c8fe07c24fbc3267c6cc403a58c5a130025e57d66cd4208a5"
  end

  bottle do
    root_url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.11"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "bc2b0b7b54af7871b1081e914142407d69928bb63033818a8e88e8c7eb1cef8a"
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
