class Fashion < Formula
  desc "Cryptographic and fuzzy hash digests for macOS binary triage"
  homepage "https://codeberg.org/melomac/fashion"
  url "https://codeberg.org/melomac/fashion/releases/download/v1.3.1/fashion.zip"
  sha256 "1d747ecef2192ecd93792552fc1b23c84c1b0de0bd9ee7db03b2c12d90bd1d33"
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
