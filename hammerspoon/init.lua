hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

hs.hotkey.bind({ "alt" }, "M", function()
	hs.application.enableSpotlightForNameSearches(true)
	local spotify = hs.application.get("Spotify")

	if spotify == nil then
		hs.application.launchOrFocus("Spotify")
		return
	end

	if spotify ~= nil then
		if spotify:isFrontmost() then
			spotify:hide()
		else
			hs.application.launchOrFocus("/Applications/Spotify.app")
		end
	end
end)

hs.hotkey.bind({ "alt" }, "D", function()
	hs.application.enableSpotlightForNameSearches(true)
	local discord = hs.application.get("Discord")

	if discord == nil then
		hs.application.launchOrFocus("Discord")
		return
	end

	if discord ~= nil then
		if discord:isFrontmost() then
			discord:hide()
		else
			hs.application.launchOrFocus("/Applications/Discord.app")
		end
	end
end)

hs.hotkey.bind({ "alt" }, "B", function()
	hs.application.enableSpotlightForNameSearches(true)

	local brave = hs.application.get("Brave Browser")

	if brave == nil then
		hs.application.launchOrFocus("Brave Browser")
		return
	end

	if brave ~= nil then
		if brave:isFrontmost() then
			brave:hide()
		else
			hs.application.launchOrFocus("/Applications/Brave Browser.app")
		end
	end
end)

hs.hotkey.bind({ "alt" }, "F", function()
	hs.application.enableSpotlightForNameSearches(true)

	local firefox = hs.application.get("Firefox")

	if firefox == nil then
		hs.application.launchOrFocus("Firefox")
		return
	end

	if firefox ~= nil then
		if firefox:isFrontmost() then
			firefox:hide()
		else
			hs.application.launchOrFocus("/Applications/Firefox.app")
		end
	end
end)

hs.hotkey.bind({ "alt" }, "S", function()
	hs.application.enableSpotlightForNameSearches(true)

	local slack = hs.application.get("Slack")

	if slack == nil then
		hs.application.launchOrFocus("Slack")
		return
	end

	if slack ~= nil then
		if slack:isFrontmost() then
			slack:hide()
		else
			hs.application.launchOrFocus("/Applications/Slack.app")
		end
	end
end)

hs.hotkey.bind({ "alt" }, "Space", function()
	hs.application.enableSpotlightForNameSearches(true)
	local ghostty = hs.application.get("Ghostty")

	if ghostty == nil then
		hs.application.launchOrFocus("Ghostty")
		return
	end

	if ghostty ~= nil then
		if ghostty:isFrontmost() then
			ghostty:hide()
		else
			hs.application.launchOrFocus("/Applications/Ghostty.app")
		end
	end
end)

hs.hotkey.bind({ "alt" }, "R", function()
	hs.application.enableSpotlightForNameSearches(true)
	local alacritty = hs.application.get("Bruno")

	if alacritty == nil then
		hs.application.launchOrFocus("Bruno")
		return
	end

	if alacritty ~= nil then
		if alacritty:isFrontmost() then
			alacritty:hide()
		else
			hs.application.launchOrFocus("/Applications/Bruno.app")
		end
	end
end)

hs.hotkey.bind({ "alt" }, "N", function()
	hs.application.enableSpotlightForNameSearches(true)
	local arc = hs.application.get("Obsidian")

	if arc == nil then
		hs.application.launchOrFocus("Obsidian")
		return
	end

	if arc ~= nil then
		if arc:isFrontmost() then
			arc:hide()
		else
			hs.application.launchOrFocus("/Applications/Obsidian.app")
		end
	end
end)
