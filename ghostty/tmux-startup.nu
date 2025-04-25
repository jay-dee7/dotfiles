#!/usr/bin/env nu

def main [] {
	let missing_tmux_session = (/opt/homebrew/bin/tmux ls | split words | is-empty)
	if $missing_tmux_session == false {
		# let tmux_session_id = (/opt/homebrew/bin/tmux ls | split words | first)
		# print $tmux_session_id
		/opt/homebrew/bin/tmux attach -t 0
	} else {
		/opt/homebrew/bin/tmux
	}
}
