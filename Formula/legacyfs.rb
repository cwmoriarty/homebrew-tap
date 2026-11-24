class Legacyfs < Formula
  desc "Read-only archival filesystem library and FUSE driver for 37 formats"
  homepage "https://github.com/cwmoriarty/legacyfs"
  url "https://github.com/cwmoriarty/legacyfs/releases/download/v0.2.0/legacyfs-0.2.0.tar.gz"
  sha256 "790aa053ef7ecdada026d436769e93c98171c6e2fd99b483452085ada0dcbb4b"
  license "MIT"
  head "https://github.com/cwmoriarty/legacyfs.git", branch: "main"

  def install
    system "make", "WITH_FUSE=auto"
    system "make", "install", "WITH_FUSE=auto", "PREFIX=#{prefix}"
  end

  test do
    assert_match "0.2.0", shell_output("#{bin}/legacyfs --version")
    assert_match "reiserfs", shell_output("#{bin}/legacyfs formats")
  end
end
