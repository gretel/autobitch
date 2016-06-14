class Autobitch < Formula
  desc "Script for `direnv` providing automatism for directory based activation of Python and Ruby Versions by utilizing `pyenv` and `ry`"
  homepage "https://github.com/gretel/autobitch"
  url "https://github.com/gretel/autobitch/archive/v0.2.tar.gz"
  sha256 "44f905dfc7e93f2a2bd594e8bcb057f09f55122b5f13fd47d5b1a8215d7859e5"
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
            local autofile="$(brew --prefix autobitch)/share/autobitch.sh"
            if test -f "$autofile"; then
                source_env "$autofile"
                auto_log_prefix "$(expand_path "$1")"
            fi
        }
    Then actual calls should happen in the individual .envrc at each location:
        if test -f "$(brew --prefix autobitch)/share/autobitch.sh"; then
            use_auto "$1" # include script
            use_auto_ruby "$1" # enable autobitching for ruby
            use_auto_python "$1" # enable autobitching for python
        fi
        test -d 'bin' && PATH_add 'bin' # add local executables to PATH (binstubs, virtualenv, ..)
    EOS
  end
end
