class Fashion < Formula
  desc "Cryptographic and fuzzy hash digests for macOS binary triage"
  homepage "https://codeberg.org/melomac/fashion"
  url "https://codeberg.org/melomac/fashion/releases/download/v1.1.1/fashion.zip"
  sha256 "a60602ff0564c302fb374dc84bc31e92ab6a7f317b078578ff5aec122cbf76eb"
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
