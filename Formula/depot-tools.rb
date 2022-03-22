class DepotTools < Formula
  desc "Tools for working with Chromium development"
  homepage "http://dev.chromium.org/developers/how-tos/install-depot-tools"
  url "https://chromium.googlesource.com/chromium/tools/depot_tools.git", using: :git, revision: "a657331e90e23e289e85a92af49b64829151f403"
  version "20220120.a657331e9"
  license "BSD-3-Clause"

#
# Credit to https://github.com/Homebrew/homebrew/pull/17675/files
#
  
  depends_on "python@3.9"
  depends_on "repo"

  def install
    dst = prefix/'tools'
    dst.mkpath unless dst.directory?
    mv Dir.glob('*'), dst
    %w[gclient gn gcl git-cl hammer drover cpplint.py presubmit_support.py
      trychange.py git-try wtf weekly git-gs zsh-goodies].each do |tool|
      (bin/tool).write <<~EOS
        #!/bin/bash
        TOOL=#{prefix}/tools/#{tool}
        export DEPOT_TOOLS_UPDATE=0
        export PATH="$PATH:#{prefix}/tools"
        exec "$TOOL" "$@"
      EOS
    end
  end

  test do
    %w[gclient presubmit_support.py trychange.py].each do |tool|
      system "#{bin}/#{tool} --version"
    end
  end
end
