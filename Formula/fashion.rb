class Fashion < Formula
  desc "Cryptographic and fuzzy hash digests for macOS binary triage"
  homepage "https://codeberg.org/melomac/fashion"
  url "https://codeberg.org/melomac/fashion/releases/download/v1.2.0/fashion.zip"
  sha256 "5aeb6c958c33607eedd804b83856bfb3b992b737826b29ba196d086784a93843"
  license "MIT"

  livecheck do
    url "https://codeberg.org/melomac/fashion/releases.atom"
    strategy :page_match
    regex(%r{/tag/v?([\d.]+)["'<\s]}i)
  end

  depends_on :macos

  def install
    bin.install "fashion"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fashion --version")
  end
end
