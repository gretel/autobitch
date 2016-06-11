class Autobitch < Formula
  desc "Script for `direnv` providing automatism for directory based activation of Python and Ruby Versions by utilizing `pyenv` and `ry`"
  homepage "https://github.com/gretel/autobitch"
  url "https://github.com/gretel/autobitch/archive/v0.1.tar.gz"
  sha256 "9649d200455945b523da20b1fb6fa71e5a22711cad623451c413a7738716a450"
  head "https://github.com/gretel/autobitch.git"
  depends_on "direnv"

  def install
    share.install "autobitch.sh"
    doc.install "README.md"
  end
  def caveats; <<-EOS.undent
    The inclusion of the script needs to be enabled manually.
    Please add the following to your .direnvrc:
        use_auto() {
            source_env "$(brew --prefix autobitch)/share/autobitch.sh"
            auto_log_prefix "$(expand_path "$1")"
        }
    Then actual calls should happen in the individual .envrc at each location:
        use_auto "$1" # include script
        use_auto_ruby "$1" # enable autobitching for ruby
        use_auto_python "$1" # enable autobitching for python
        test -d 'bin' && PATH_add 'bin' # add local executables to PATH (binstubs, virtualenv, ..)
    EOS
  end
end
