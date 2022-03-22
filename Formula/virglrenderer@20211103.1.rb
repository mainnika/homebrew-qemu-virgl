class VirglrendererAT202111031 < Formula
  desc "VirGL virtual OpenGL renderer"
  homepage "https://gitlab.freedesktop.org/virgl/virglrenderer"
  url "https://code.tokarch.uk/third_party/virglrenderer.git", revision: "754a303015ef082f9c0da48a67398ad376191964"
  version "20211103.1"
  license "MIT"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build

  depends_on "libangle"
  depends_on "libepoxy@20211103.1"

  keg_only :versioned_formulae

  def install
    mkdir "build" do
      system "meson", *std_meson_args,
             "-Dc_args=-I#{Formula["libepoxy@20211103.1"].opt_prefix}/include -I#{Formula["libangle"].opt_prefix}/include",
             "-Dc_link_args=-L#{Formula["libepoxy@20211103.1"].opt_prefix}/lib -L#{Formula["libangle"].opt_prefix}/lib",
             ".."
      system "ninja", "-v"
      system "ninja", "install", "-v"
    end
  end

  test do
    system "true"
  end
end
