class Fashion < Formula
  desc "Cryptographic and fuzzy hash digests for macOS binary triage"
  homepage "https://codeberg.org/melomac/fashion"
  url "https://codeberg.org/melomac/fashion/releases/download/v1.8.0/fashion.zip"
  sha256 "90ec4b247885f8b6357c00c5eca8a41920d8e45cb940dc4034de8dd441a8f0fb"
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
    generate_completions_from_executable(bin/"fashion", "--generate-completion-script")
  end

  test do
    (testpath/"hello").write "hello\n"
    digest = "5891b5b522d5df086d0ff0b110fbd9d21bb4fc7163af34d08286a2e846f6be03"
    assert_match digest, shell_output("#{bin}/fashion #{testpath}/hello")
  end
end
