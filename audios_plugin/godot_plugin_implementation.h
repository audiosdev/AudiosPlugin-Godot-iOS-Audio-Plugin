//
//  godot_plugin_implementation.h
//  godot_plugin
//
//  Created by Audiosdroid on 07.06.2022.
//  Copyright © 2022 Godot. All rights reserved.
//

#ifndef godot_plugin_implementation_h
#define godot_plugin_implementation_h

#include "core/object.h"
#import <AVFoundation/AVFoundation.h>

class AudiosPlugin : public Object{
    GDCLASS(AudiosPlugin, Object);
    
    static void _bind_methods();
    AVAudioRecorder *audioRecorder;
    AVAudioPlayer *audioPlayer;
    AVAudioEngine *audioEngine;
    AVAudioUnitVarispeed *timePitch;
    AVAudioPlayerNode *playerNode;
    
    float mTempo;
public:
    
    Error init();
    
    AudiosPlugin();
    void recordAudio();
    bool isRecording();
    void playAudio();
    void stopAudio();
    void setTempo(float val);

    ~AudiosPlugin();
};

#endif /* godot_plugin_implementation_h */
