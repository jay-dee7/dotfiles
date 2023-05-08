# dotfiles

This is a simple repository with neovim, alacritty and starship configuration. We have two make commands, `link` and 
`unlink`. 

1. link - creates a symlink to the `nvim`, `alacritty`, and `starship` directories from this repository to `$HOME/.config`
2. unlink - removes the  symlink from `nvim`, `alacritty`, and `starship` directories

### To link the directories (set the configuration)

```bash
make link
```

### To unlink the directories (reset the configuration to stock)

```bash
make unlink
```
