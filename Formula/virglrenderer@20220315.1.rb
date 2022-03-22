class VirglrendererAT202203151 < Formula
  desc "VirGL virtual OpenGL renderer"
  homepage "https://gitlab.freedesktop.org/virgl/virglrenderer"
  url "https://code.tokarch.uk/third_party/virglrenderer.git", revision: "c8b112f5f530f80eb6dbf6578354433a6a3eaa2b"
  version "20220315.1"
  license "MIT"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build

  depends_on "libangle"
  depends_on "libepoxy@20220315.1"

  keg_only :versioned_formulae

  def install
    mkdir "build" do
      system "meson", *std_meson_args,
              "-Dc_args=-I#{Formula["libepoxy@20220315.1"].opt_prefix}/include -I#{Formula["libangle"].opt_prefix}/include",
              "-Dc_link_args=-L#{Formula["libepoxy@20220315.1"].opt_prefix}/lib -L#{Formula["libangle"].opt_prefix}/lib",
              ".."
      system "ninja", "-v"
      system "ninja", "install", "-v"
    end
  end

  test do
    system "true"
  end
end
  

