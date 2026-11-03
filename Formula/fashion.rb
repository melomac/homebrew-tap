class Fashion < Formula
  desc "Cryptographic and fuzzy hash digests for macOS binary triage"
  homepage "https://codeberg.org/melomac/fashion"
  url "https://codeberg.org/melomac/fashion/releases/download/v1.7.1/fashion.zip"
  sha256 "ab8b78ff15522c1faa85f36288cedae1f6e6eb49b28531ec371af51721ab1b96"
  license "GPL-3.0-or-later"

  livecheck do
    url "https://codeberg.org/melomac/fashion/releases.atom"
    strategy :page_match
    regex(%r{/tag/v?([\d.]+)["'<\s]}i)
  end

  head do
    url "https://codeberg.org/melomac/fashion.git", branch: "main"
    depends_on xcode: ["26.0", :build]
  end

  depends_on :macos

  def install
    if build.head?
      system "swift", "build", "--disable-sandbox", "-c", "release"
      bin.install ".build/release/fashion"
    else
      bin.install "fashion"
    end
    prefix.install "LICENSE", "NOTICE"
  end

  test do
    (testpath/"hello").write "hello\n"
    assert_match "5891b5b522d5df086d0ff0b110fbd9d21bb4fc7163af34d08286a2e846f6be03", shell_output("#{bin}/fashion #{testpath}/hello")
  end
end