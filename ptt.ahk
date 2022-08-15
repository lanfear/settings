; create and run 'SOUNDCARD ANALYSIS.ahk' from https://www.autohotkey.com/docs/commands/SoundSet.htm
; screenshot and close window
; mute the microphone in Recording > Properties > Levels
; run 'SOUNDCARD ANALYSIS.ahk' again and find the row where MUTE has changed to 'On'
; replace [#MIXER_ID] with changed row, i.e. 'SoundSet $val, Master, Mute, 11'

; notes to self
; because lenovo machines dont have scrolllock, use 'sharpkeys' to map num-enter to scrolllock and map that
; this is because ahk/windows cant natively detect difference between num-enter and enter

; the current device-id detected from script above
MIXERID = 7
HOTKEY = NumpadEnter
SHOWUNMUTE = 0

; xbutton2 = Mouse Button 5 (* ignores modifier keys such as Shift and Ctrl)
*NumpadEnter::
  UnMute(MIXERID)
  Loop
  {
    Sleep, 10
    GetKeyState, State, %HOTKEY%, P
    if State = U
	{
      break
    }
  }
  SetTimer, Mute, 200
return
Mute:
  SetTimer, Mute, Off
  Mute(MIXERID)
return
RemoveToolTip:
  ToolTip
return

SS( $val, $device )
{
  SoundSet $val, Master, Mute, $device
  if $val = 0
	UnMuteMsg()
  else
    MuteMsg()
}

Mute( $device )
{
  SS(1, $device)
}

MuteMsg()
{
  ToolTip, 🔇
  SetTimer, RemoveToolTip, -1000
}

UnMute( $device )
{
  SetTimer, Mute, Off
  SS(0, $device)
}

UnMuteMsg()
{
  ToolTip, 🔊
  SetTimer, RemoveToolTip, -1000
}

