class Libangle < Formula
  desc "Conformant OpenGL ES implementation for Windows, Mac, Linux, iOS and Android"
  homepage "https://github.com/google/angle"
  url "https://github.com/google/angle.git", using: :git, revision: "29b222a3c07c541cafa459ae6886134da3493a4b"
  version "4844.29b222a"
  license "BSD-3-Clause"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "libangle-deps@4844" => :build

  def install
    libangleDeps = "#{Formula["libangle-deps@4844"].opt_prefix}/deps"
    Dir.each_child(libangleDeps) do |dep|
      rm_rf "#{dep}"
      ln_s "#{libangleDeps}/#{dep}", "#{dep}"
    end

    path = PATH.new(ENV["PATH"], "#{Dir.pwd}/third_party/depot_tools")
    with_env(PATH: path) do
      if Hardware::CPU.arm?
        system "gn", "gen", "--args=is_debug=false target_cpu=arm64 use_custom_libcxx=false treat_warnings_as_errors=false", "./angle_build"
      else
        system "gn", "gen", "--args=is_debug=false use_custom_libcxx=false treat_warnings_as_errors=false", "./angle_build"
      end

      system "ninja", "-v", "-C", "angle_build"

      lib.install "angle_build/libEGL.dylib"
      lib.install "angle_build/libGLESv2.dylib"
      lib.install "angle_build/libGLESv1_CM.dylib"

      include.install Pathname.glob("include/*")
    end
  end

  test do
    system "true"
  end
end
