class Fashion < Formula
  desc "Cryptographic and fuzzy hash digests for macOS binary triage"
  homepage "https://codeberg.org/melomac/fashion"
  url "https://codeberg.org/melomac/fashion/releases/download/v1.0.1/fashion.zip"
  sha256 "b53f153363ed348b054a6ecc323f2822bf732c3fcdc558027ebe6d88715e651d"
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
