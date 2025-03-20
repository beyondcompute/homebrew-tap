class SwitchKeyboardLayout < Formula
  desc "Command-line keyboard layout switcher"
  homepage "https://github.com/beyondcompute/switch_keyboard_layout"
  url "https://github.com/beyondcompute/switch_keyboard_layout/archive/refs/tags/2025-03-21.tar.gz"
  sha256 "ea922e403463fc3236e2140f98f1a70f470b8240cfc821b54af26ee5a566190c"
  license "MIT"

  head "https://github.com/beyondcompute/switch_keyboard_layout.git", branch: "main"

  depends_on :macos

  def install
    system ENV.cc,
      "-ObjC",
      "-O3",
      "-framework", "Carbon", "-framework", "Foundation",
      "switch_keyboard_layout.m",
      "-o", "switch_keyboard_layout"
    bin.install "switch_keyboard_layout"
    unless build.bottle?
      bash_completion.install "completions/bash" => "switch_keyboard_layout"
      zsh_completion.install "completions/zsh" => "_switch_keyboard_layout"
    end
  end

  def caveats
    <<~EOS
      📝 To learn more about how to activate completions for your shell, refer to:
      https://docs.brew.sh/Shell-Completion
    EOS
  end

  test do
    system "#{bin}/switch_keyboard_layout", "--help"
  end
end
