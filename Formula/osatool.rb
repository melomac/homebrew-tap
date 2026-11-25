class Osatool < Formula
  desc "Decompiler and disassembler for compiled AppleScript, also run-only"
  homepage "https://codeberg.org/melomac/osatool"
  url "https://codeberg.org/melomac/osatool/releases/download/v1.0.0/osatool.zip"
  sha256 "359a6b39881ca2476aa56d3b11c168b4658e1ef6a5a1f9603f599e87c0060644"
  license "GPL-3.0-or-later"

  livecheck do
    url "https://codeberg.org/melomac/osatool/releases.atom"
    strategy :page_match
    regex(%r{/tag/v?([\d.]+)["'<\s]}i)
  end

  head do
    url "https://codeberg.org/melomac/osatool.git", branch: "main"
    depends_on xcode: ["27.0", :build]
  end

  depends_on :macos

  def install
    if build.head?
      system "swift", "build", "--disable-sandbox", "-c", "release"
      bin.install ".build/release/osatool"
    else
      bin.install "osatool"
    end
    prefix.install "LICENSE", "NOTICE"
    generate_completions_from_executable(bin/"osatool", "--generate-completion-script")
  end

  test do
    # A script compiled from `return -2`.
    script = <<~EOS
      RmFzZFVBUyAxLjEwMS4xMA4AAAAED/////4AAQACAf//AAAB//4AAA4AAQAADxAAAgAD//0AAwAE
      Af/9AAAQAAMAAf/8Cv/8ABguYWV2dG9hcHBudWxsAACAAAAAkAAqKioqDgAEAAcQ//v/+v/5//gA
      BQAG//cK//sAGC5hZXZ0b2FwcG51bGwAAIAAAACQACoqKioB//oAAAH/+QAAAv/4AAAQAAUAABAA
      BgAB//YD//b//hH/9wAD4A8PAGFzY3IAAQAN+t7erQ==
    EOS
    (testpath/"script.scpt").binwrite script.unpack1("m")
    assert_equal "return -2\n", shell_output("#{bin}/osatool decompile #{testpath}/script.scpt")
    assert_match "PushLiteral", shell_output("#{bin}/osatool disassemble #{testpath}/script.scpt")
  end
end
