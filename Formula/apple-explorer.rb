class AppleExplorer < Formula
  desc "Portable HFS, HFS+, APFS, FileVault 2, sparsebundle, and Time Machine reader"
  homepage "https://github.com/cwmoriarty/apple-explorer"
  url "https://github.com/cwmoriarty/apple-explorer/releases/download/v0.1.0/apple-explorer-0.1.0.tar.gz"
  sha256 "9ddefbdd7c3278d41cc1d03bec099c734ed71ac6c58129337c070c447053025e"
  license "MIT"
  head "https://github.com/cwmoriarty/apple-explorer.git", branch: "main"

  def install
    system "make", "WITH_FUSE=auto"
    system "make", "install", "WITH_FUSE=auto", "PREFIX=#{prefix}"
  end

  test do
    assert_match "0.1.0", shell_output("#{bin}/apple-explorer --version")
  end
end
