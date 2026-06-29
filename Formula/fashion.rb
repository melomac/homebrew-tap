class Fashion < Formula
  desc "Cryptographic and fuzzy hash digests for macOS binary triage"
  homepage "https://codeberg.org/melomac/fashion"
  url "https://codeberg.org/melomac/fashion/releases/download/v1.0.3/fashion.zip"
  sha256 "d0df9840972756199d0dea7413b3a244feef6b691598dd33abf718ce9f4a9b25"
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
