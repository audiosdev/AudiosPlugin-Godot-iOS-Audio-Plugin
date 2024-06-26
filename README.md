# Godot-iOS-Audio-Plugin (AudiosPlugin)
This plugin solves the Godot game engine audio recording and playback issue in iOS devices. Please open the Audios Plugin XCode Project and compile the project. You can also use the libaudios_plugin.a binary in your project.

# Easy Integration Steps
1) Unzip the Godot.zip file to Godot folder for Godot's header files. You can generate the latest Godot header files. See Getting Godot engine headers below.
2) Open the XCode Audios Plugin project in XCode and compile.
3) Copy libaudios_plugin.a and audiosplugin.gdip to your Godot project's ios folder.
4) Initialize the Audios Plugin in ready function as follows:

```
var audiosPlugin = null

func _ready():
if Engine.has_singleton("AudiosPlugin"):
		audiosPlugin = Engine.get_singleton("AudiosPlugin")
		var ret = audiosPlugin.init()
		print("iOS plugin is available %d", ret)
	else:
		print("iOS plugin is not available on this platform.")
   
     # Your other initialization code
end
```

5) Start recording:
```
  if audiosPlugin != null:	
	audiosPlugin.recordAudio()
 ```
 
6) Stop recording and play
```
if audiosPlugin != null:
  audiosPlugin.stopAudio()
  audiosPlugin.setTempo(value)  #Set pitch of the recording while playing (optional)
  audiosPlugin.playAudio()

```
7) Disable "Enable Audio Input" from Godot project settings (Project->Project Settings->Audio) in order to prevent runtime crash. This plugin gets the microphone permission itself.
8) Enable the iOS Godot Plugin when exporting the project and PCK file from "Project->Export" menu

# Methods

    Audiosplugin();
    Error init() : initialize the Audios plugin
    void recordAudio() : Start recording audio
    bool isRecording() : Check if recording audio
    void playAudio()   : Play the recorded audio
    void stopAudio()   : Stop recording and playing
    void setTempo(float val) : Set tempo of the recording while playing. 
    1.0 is the original tempo. 2.0 is 2x. 0.5 is 1/2x. The tempo also changes pitch.
    

# Godot iOS Audio Plugin Advanced Setup
This repo contains a Xcode and SCons configuration to build an Godot Audio plugin for iOS.
Xcode project and Scons configuration allows to build static `.a` library, that could be used with `.gdip` file as Godot's plugin to include platform functionality into exported application.

# Initial setup

## Getting Godot engine headers

To build iOS plugin library it's required to have Godot's header files including generated ones. So running `scons platform=iphone target=<release|debug|release_debug>` in `godot` submodule folder is required.

# Working with Xcode

Building project should be enough to build a `.a` library that could be used with `.gdip` file.

# Working with SCons

Running `scons platform=ios arch=<arch> target=<release|debug|release_debug> target_name=<library_name> version=<3.2|4.0>` would result in plugin library for specific platform.
Compiling for multiple archs and using `lipo -create .. -output ..` might be required for release builds.

# Please see my website and apps:
I develop Android, iOS and Windows applications. Please see my website: https://www.audiosdroid.com

[![audiosdroid.com](https://static.wixstatic.com/media/f49253_d1eb5b5d494e41498ba9fde1e1feda20~mv2.png/v1/fill/w_191,h_109,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/audios_colored2_1_alpha512.png)](https://www.audiosdroid.com)

# Sponsorship
I developed an iOS Audio Godot plugin to resolve the audio recording issue in iOS devices for your use. You can freely use this plugin source code in your project with MIT License. Please support me by donating:

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/C1C8Y56OI)

This project is tested with [BrowserStack](https://email.browserstack.com/c/eJwdjTuuwyAURFdjOiz-kILiNW8bEZ97BYodO4Dl7QdFmmqOZg54bixzWljpSPY66mxJ9UY-rGSOK4zxKQQXIQYEzlNEJx5C57D2muFVPxQbfC54D4qZnke-OoQ-ON1DfUsatwuoySonZ5VG2vs52qIYTLytc9pLhv5a07GT4pEFKUUOzEiNLiihrWGAIHVyXJhINl_GOPsi_xbxP3Pf9xrbcXdofYT0-5k1aR7DqGV3errKMX62yb4wr0un).
