. $HOME/.bashrc

#eval $(keychain --eval --agents ssh -Q --quiet id_ecdsa)
eval $(keychain --eval -Q --quiet id_rsa)


# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin":$PATH
fi

if [ -d "$HOME/go/bin" ] ; then
    PATH="$HOME/go/bin":$PATH
fi

if [ -d "$HOME/.cabal/bin" ] ; then
    PATH="$HOME/.cabal/bin":$PATH
fi

if [ -d "$HOME/.tmuxinator/scripts/tmuxinator" ] ; then 
    PATH="$HOME/.tmuxinator/scripts/tmuxinator":$PATH
    source $HOME/.tmuxinator/scripts/tmuxinator
fi

if [ -d "$HOME/.gem/ruby/1.9.1/bin" ] ; then
    PATH="$HOME/.gem/ruby/1.9.1/bin":$PATH
fi

if [ -d "$HOME/go/bin" ] ; then
    PATH="$HOME/go/bin":$PATH
fi
