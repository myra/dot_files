# modified commands
alias reload='source ~/.bashrc'
alias reboot="sudo reboot"
alias shutdown="sudo shutdown -h now"
alias updatedb="sudo updatedb"
alias mount="sudo mount"
alias reloadp="source ~/.bash_profile"
alias reloada="source ~/.bash_aliases"
alias mylocate="locate -d ~/.config/myconfig/files.db"
alias cdrepos="cd /mnt/myra/repos"
alias cdproj="cd /mnt/myra/projects"
alias cleandir="rmd src && rmd pkg && rm -vf *.log && rm -vf *.log.* && rm -vf *.log.*"
alias newsbeuter="newsbeuter -u /home/myra/.config/newsbeuter/urls -C /home/myra/.config/newsbeuter/config" 
alias pacserve="/home/myra/bin/mypacserve"
alias pbgeta="pbget --aur-only"
alias xp='xprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""'

# requires colordiff package

if [ -x /bin/dircolors ]; then
  eval "`dircolors -b`"
  alias ls='ls -hF --color=always'
  alias lr='ls -R --color=always'                    # recursive ls
  alias ll='ls -l --color=always'
  alias la='ll -A --color=always'
  alias lx='ll -BX --color=always'                   # sort by extension
  alias lz='ll -rS --color=always'                   # sort by size
  alias lt='ll -rt --color=always'                  # sort by date
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  alias most='most'
  alias less='most'
  alias dir='ls -l --color=always'
  alias diff='colordiff'
  alias dirw='ls -al --color=always'
fi

alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias nano='nano -w'
alias ping='ping -c 3'

# new commands
alias da='date "+%A, %B %d, %Y [%T]"'
alias du1='du --max-depth=1'
alias hist='history | grep $1'      # requires an argument
alias openports='sudo netstat --all --numeric --programs --inet'
alias pg='ps -Af | grep $1'         # requires an argument

# cd
alias home='cd ~'
alias back='cd $OLDPWD'
alias cd..='cd ..'
alias ..='cd ..'
alias up='cd ../'
alias up2='cd ../../'
alias up3='cd ../../../'
alias up4='cd ../../../../'

#safety features
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias rmd='rm -rfv'

#pacman
#alias pacman="pacman-color"
alias pacs="sudo pacman -S --config /home/myra/pacman_maint/pacman.conf --cachedir /var/cache/pacman/pkg --dbpath /var/lib/pacman"
alias pacsy="sudo pacman -Sy --config /home/myra/pacman_maint/pacman.conf --cachedir /var/cache/pacman/pkg --dbpath /var/lib/pacman"
alias pacsyy="sudo pacman -Syy --config /home/myra/pacman_maint/pacman.conf --cachedir /var/cache/pacman/pkg --dbpath /var/lib/pacman"
alias pacq="sudo pacman -Qi --config /home/myra/pacman_maint/pacman.conf --cachedir /var/cache/pacman/pkg --dbpath /var/lib/pacman"
alias pacu="sudo pacman -U --config /home/myra/pacman_maint/pacman.conf --cachedir /var/cache/pacman/pkg --dbpath /var/lib/pacman"
alias pacsu="sudo pacman -Su --config /home/myra/pacman_maint/pacman.conf --cachedir /var/cache/pacman/pkg --dbpath /var/lib/pacman"
alias pacr="sudo pacman -R --config /home/myra/pacman_maint/pacman.conf --cachedir /var/cache/pacman/pkg --dbpath /var/lib/pacman"
alias pacrs="sudo pacman -Rs --config /home/myra/pacman_maint/pacman.conf --cachedir /var/cache/pacman/pkg --dbpath /var/lib/pacman"
alias pacqu="sudo pacman -Qu --config /home/myra/pacman_maint/pacman.conf --cachedir /var/cache/pacman/pkg --dbpath /var/lib/pacman"
alias makepkg="makepkg -sL"
#alias addpkg="repo-add -s /mnt/myra/myra/build/Packages/pkgs.db.tar.gz"

#build in clean chroot
#alias makechrootpkg="sudo makechrootpkg -r $CHROOT -- -i"

#pacsearch
alias pacss="pacsearch"
pacsearch () {
  echo -e "$(pacman --config /home/myra/pacman_maint/pacman.conf -Ss $@ | sed \
  -e 's#core/.*#\\033[1;31m&\\033[0;37m#g' \
  -e 's#extra/.*#\\033[0;32m&\\033[0;37m#g' \
  -e 's#testing/.*#\\033[1;33m&\\033[0;37m#g' \
  -e 's#community/.*#\\033[1;35m&\\033[0;37m#g' \
  -e 's#community-testing/.*#\\033[0;33m&\\033[0;37m#g' \
  -e 's#^.*/.* [0-9].*#\\033[0;36m&\\033[0;37m#g' )"
}
