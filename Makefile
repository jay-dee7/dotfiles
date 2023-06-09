link:
	@ln -sFf ${PWD}/nvim ~/.config/nvim
	@ln -sFf ${PWD}/alacritty ~/.config/alacritty
	@ln -sFf ${PWD}/starship ~/.config/starship
	@ln -sFf ${PWD}/tmux/tmux.config ~/.tmux.conf
	@echo "Done symlinking dirs ✔︎"

unlink:
	@unlink ~/.config/nvim
	@unlink ~/.config/alacritty
	@unlink ~/.config/starship
