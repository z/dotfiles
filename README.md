# dotfiles

A collection of my dotfiles for both servers and clients.

### zsh

To use the zsh dotfiles, you must first install [zsh](http://www.zsh.org/) and [oh-my-zsh](http://ohmyz.sh/).
Be sure to copy both `.zshrc` and `.oh-my-zsh/` to your home directory.

By default, `zed.zsh-theme` requires the following plugins, which are not included with oh-my-zsh:

#### Plugins

###### zsh-autosuggestions

[more info](https://github.com/zdharma/history-search-multi-word)

```
git clone git://github.com/zdharma/history-search-multi-word.git ~/.oh-my-zsh/custom/plugins/history-search-multi-word.git
```

###### zsh-syntax-highlighting

[more info](https://github.com/zsh-users/zsh-syntax-highlighting)

```
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting 
```

###### zsh-autosuggestions


[more info](https://github.com/zsh-users/zsh-autosuggestions)

```
git clone git://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions 
```

###### Enabling/Disabling zsh plugins

These plugins are used to bring [fish](http://fishshell.com)-like behavior to zsh.

If you don't like this behavior, these can be disabled in `.zshrc` by commenting out the following:

```
AUTOSUGGESTION="true"
ENHANCED_COMPLETION="true"
```

You should also remove `zsh-syntax-highlighting zsh-autosuggestions` from the plugin list if you decide to go this route.

### tmux

Uses screen-like binds and a nice looking theme.

```
cp -R .tmux* ~
```

### screen

More informative clean theme.

```
cp -R .screenrc ~
```

### vim

Requires [vundle](https://github.com/VundleVim/Vundle.vim) for plugins (NERDtree, tabman).

```
cp -R .vim* ~
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
```

### License

MIT
