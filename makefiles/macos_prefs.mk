# Makefile - macOS Preferences
# https://macos-defaults.com

.PHONY: prefs
PREFS = prefs_finder prefs_display prefs_dock prefs_textedit prefs_safari prefs_keymap prefs_theme
prefs: $(PREFS)

.PHONY: prefs_finder
prefs_finder:
	chflags nohidden ~/Library												# Don't hide Library
	defaults write NSGlobalDomain AppleShowAllExtensions -bool true 		# Show extension
	defaults write com.apple.finder AppleShowAllFiles -bool YES 			# Show hidden files
	defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES 		# Posix path in title
	defaults write com.apple.finder ShowPathbar -bool YES 					# Show path bar
	defaults write com.apple.universalaccess "showWindowTitlebarIcons" -bool "true"
	killall -9 Finder

.PHONY: prefs_display
prefs_display:
	sudo pmset -a displaysleep 5	# sleep display after 5 min for all
	# Configure nightshift
	nightlight on
	nightlight schedule start

.PHONY: prefs_dock
prefs_dock:
	defaults write com.apple.dock autohide -bool true 			# Autohide dock
	defaults write com.apple.dock tilesize -int 50 				# Dock size
	killall Dock

.PHONY: prefs_textedit
prefs_textedit:
	defaults write com.apple.TextEdit RichText 0 													# Default to plaintext
	defaults write com.apple.TextEdit NSShowAppCentricOpenPanelInsteadOfUntitledFile -bool false 	# Always open to editor
	defaults write com.apple.TextEdit CorrectSpellingAutomatically 0 								# No spell checking

.PHONY: prefs_safari
prefs_safari:
	# defaults write com.apple.Safari ShowFullURLInSmartSearchField 1 			# Show full url

.PHONY: prefs_xcode
prefs_xcode:
	defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool YES 			# show time to compile
	defaults write com.apple.dt.Xcode IDEShowPrebuildLogs -bool YES					# show prebuild steps
	defaults write com.apple.dt.Xcode ShowDVTDebugMenu -bool YES					# show debug menu
	defaults write com.apple.dt.Xcode ApplePersistenceIgnoreState -bool YES			# don't reopen last project
	defaults write com.apple.dt.Xcode IDEDisableStateRestoration -bool YES			# don't restore last open files
	defaults write -g _NS_4445425547 -bool true										# enable appkit debug menu

.PHONY: prefs_keymap
prefs_keymap:				
	defaults write -g ApplePressAndHoldEnabled 0
	hidutil property --set '{ "UserKeyMapping": [{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x7000000E4}] }'

DESKTOP_IMG := "./bin/desktop_image"
DARKMODE 	:= "./bin/darkmode"
.PHONY: pref_theme
prefs_theme:
	$(DESKTOP_IMG) "/System/Library/Desktop Pictures/Solid Colors/Black.png"
	$(DARKMODE) true
