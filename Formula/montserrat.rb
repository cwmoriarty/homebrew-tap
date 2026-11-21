class Montserrat < Formula
  desc "Native read/write ext4 and Linux filesystem tool for modern macOS"
  homepage "https://github.com/cwmoriarty/montserrat"
  url "https://github.com/cwmoriarty/montserrat/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "9e02d2b34da9a1ce4144e2ab4c3d56b7a3ba5b5a8ac7ba53fd2124b612cd746b"
  license "MIT"
  head "https://github.com/cwmoriarty/montserrat.git", branch: "main"

  depends_on xcode: ["16.0", :build]
  depends_on macos: :sequoia

  def install
    system "./scripts/build.sh"
    bin.install "dist/bin/montserrat"
    bin.install "dist/bin/montserratd" if File.exist?("dist/bin/montserratd")
    (prefix/"engines").install Dir["dist/engines/*"]
    (prefix/"conf").install Dir["dist/conf/*"]
    (prefix/"FSKit").install Dir["dist/FSKit/*"]
  end

  def caveats
    <<~EOS
      Montserrat requires FUSE-T (or macOS 15+ FSKit) for mounting user-space filesystems.
      If not already installed, run:
          brew install --cask macos-fuse-t/cask/fuse-t  

      To register and start the background auto-mount daemon:
        sudo montserrat daemon install
    EOS
  end

  test do
    assert_match "montserrat version", shell_output("#{bin}/montserrat --version")
    assert_match "Montserrat Engine", shell_output("#{bin}/montserrat engines")
  end
end
