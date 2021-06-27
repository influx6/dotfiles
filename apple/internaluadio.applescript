-- Sets your audio input source to "Internal Microphone"
-- Frequently needed if you use bluetooth headpohones and
-- run the Xcode iOS simulator, which will often set your
-- headphones to be the input device, resulting in a drastic
-- decrease in sound quality, and making it mono 

tell application "System Preferences" to activate
tell application "System Preferences"
	reveal anchor "input" of pane id "com.apple.preference.sound"
end tell
delay 0.5
tell application "System Events" to tell process "System Preferences"
	tell table 1 of scroll area 1 of tab group 1 of window 1
		select (row 1 where value of text field 1 is "Macbook Pro Microphone")
	end tell
end tell
quit application "System Preferences"