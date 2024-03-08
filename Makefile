link:
	@ln -sFf ${PWD}/nvim ${HOME}/.config/nvim
	@ln -sFf ${PWD}/alacritty ${HOME}/.config/alacritty
	@ln -sFf ${PWD}/starship ${HOME}/.config/starship
	@ln -sFf ${PWD}/ghostty ${HOME}/.config/ghostty
	@ln -sFf ${PWD}/tmux/tmux.config ${HOME}/.tmux.conf
	@echo "Done symlinking dirs ✔︎"

unlink:
	@unlink ${HOME}/.config/nvim
	@unlink ${HOME}/.config/alacritty
	@unlink ${HOME}/.config/starship
	@unlink ${HOME}/.config/ghostty
