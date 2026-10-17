class C6 < Formula
  desc "carbon6 command line: run and follow agent sessions through a carbon6 head"
  homepage "https://github.com/carbon6-dev/carbon6"
  version "0.3.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_arm do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.2/c6-0.3.2-darwin-arm64.tar.gz"
    sha256 "9c2ac6c01df2fb9fc167a6444416ff7d988c117d11db80201d58580f26a84b81"
  end
  on_intel do
    url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.2/c6-0.3.2-darwin-x86_64.tar.gz"
    sha256 "0002134bf0ace5cbb459e599a582d362e1c4a0e2eeb73b649162138f9eb0cfd1"
  end

  bottle do
    root_url "https://github.com/carbon6-dev/carbon6/releases/download/v0.3.2"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "1d0b2f9e024f9f28c365a70e8e7f84ea0851e2ef85d7d91651c512b6bc859b63"
    sha256 cellar: :any_skip_relocation, big_sur: "6c366c0c59e7feab5041078796ed97f5b218fc9fcf21f98aee02ada42d7bb5b6"
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
