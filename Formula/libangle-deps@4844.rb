class LibangleDepsAT4844 < Formula
  desc "Third party dependencies for Libangle"
  homepage "https://github.com/google/angle"
  url "https://github.com/google/angle.git", using: :git, revision: "29b222a3c07c541cafa459ae6886134da3493a4b"
  version "4844.29b222a"
  license "Various"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "depot-tools" => :build

  keg_only :versioned_formula

  def install
    system "python3", "scripts/bootstrap.py"
    system "gclient", "sync"

    dst = prefix/'deps'
    dst.mkpath unless dst.directory?

    %w[.cipd .gclient .gclient_entries build buildtools testing third_party tools].each do |f|
      mv f, dst
    end
  end

  test do
    system "true"
  end
end
