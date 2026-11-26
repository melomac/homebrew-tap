class Asbs < Formula
  desc "Look up domains or URLs with the Safe Browsing service of macOS"
  homepage "https://codeberg.org/melomac/safebrowsing"
  url "https://codeberg.org/melomac/safebrowsing/releases/download/v1.0.0/asbs.zip"
  sha256 "2c81f7c580990f194afefa25b64a42e75d382499008e67a23b31c7e0fb6d81e3"
  license "GPL-3.0-or-later"

  livecheck do
    url "https://codeberg.org/melomac/safebrowsing/releases.atom"
    strategy :page_match
    regex(%r{/tag/v?([\d.]+)["'<\s]}i)
  end

  head do
    url "https://codeberg.org/melomac/safebrowsing.git", branch: "main"
    depends_on xcode: ["26.0", :build]
  end

  depends_on :macos

  def install
    if build.head?
      system "swift", "build", "--disable-sandbox", "-c", "release"
      bin.install ".build/release/asbs"
    else
      bin.install "asbs"
    end
    prefix.install "LICENSE"
    generate_completions_from_executable(bin/"asbs", "--generate-completion-script")
  end

  test do
    # No lookup: the Safe Browsing service is not asked, a name is only parsed.
    assert_equal "1.0.0\n", shell_output("#{bin}/asbs --version")
    assert_match "Invalid domain name or URL: not a URL", shell_output("#{bin}/asbs 'not a URL' 2>&1")
  end
end
