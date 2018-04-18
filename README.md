# vim-tmux-integration

This vim plugin will check map <C-H> <C-J> <C-K> <C-L> to move around vim windows, unless one of those windows in on the edge of the tab, in which case to will do a `tmux select-pane` in the appropriate direction

It can be installed using pathogen:
```
cd ~/.vim/bundle
git clone https://github.com/danielcliffordmiller/vim-tmux-integration.git
```
