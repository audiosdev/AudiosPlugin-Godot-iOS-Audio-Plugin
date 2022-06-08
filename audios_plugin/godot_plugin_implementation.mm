//
//  godot_plugin_implementation.m
//  godot_plugin
//
//  Created by Audiosdroid on 07.06.2022.
//  Copyright © 2022 Godot. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "core/project_settings.h"
#include "core/class_db.h"

#import "godot_plugin_implementation.h"

void AudiosPlugin::_bind_methods() {
    ClassDB::bind_method(D_METHOD("init"),        &AudiosPlugin::init);
    ClassDB::bind_method(D_METHOD("recordAudio"), &AudiosPlugin::recordAudio);
    ClassDB::bind_method(D_METHOD("playAudio"),   &AudiosPlugin::playAudio);
    ClassDB::bind_method(D_METHOD("isRecording"), &AudiosPlugin::isRecording);
    ClassDB::bind_method(D_METHOD("stopAudio"),   &AudiosPlugin::stopAudio);
    ClassDB::bind_method(D_METHOD("setTempo"),    &AudiosPlugin::setTempo);
    
}

Error AudiosPlugin::init() {
    NSLog(@"AudiosPlugin Initing...");
    
    NSArray  *dirPaths;
    NSString *docsDir;
    mTempo = 1.0;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    NSString *soundFilePath = [docsDir
                               stringByAppendingPathComponent:@"sound.caf"];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    NSDictionary *recordSettings = [NSDictionary
                                    dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithInt:AVAudioQualityMin],
                                    AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:16],
                                    AVEncoderBitRateKey,
                                    [NSNumber numberWithInt: 2],
                                    AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:44100.0],
                                    AVSampleRateKey,
                                    nil];
    
    NSError *error = nil;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord
                        error:nil];
    
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        if (granted) {
            NSLog(@"AudiosPlugin Mic Granted...");
        }
        else {
            // Microphone disabled code
        }
    }];
    
    audioEngine = [[AVAudioEngine alloc] init];
    playerNode  = [[AVAudioPlayerNode alloc] init];
    timePitch   = [[AVAudioUnitVarispeed alloc] init];
    
    AVAudioMixerNode *mixer = audioEngine.mainMixerNode;
    [audioEngine attachNode:timePitch];
    [audioEngine attachNode:playerNode];
    
    
    [audioEngine connect:playerNode to:timePitch format:[mixer outputFormatForBus:0]];
    [audioEngine connect:timePitch to:mixer format:[mixer outputFormatForBus:0]];
    [audioEngine startAndReturnError:nil];
    
    audioRecorder = [[AVAudioRecorder alloc]
                     initWithURL:soundFileURL
                     settings:recordSettings
                     error:&error];
    
    
    if(audioRecorder != nil)
        NSLog(@"AudioRecorder was created successfully");
    
    if (error)
    {
        NSLog(@"error: %@", [error localizedDescription]);
    } else {
        [audioRecorder prepareToRecord];
    }
    return OK;
}

void AudiosPlugin::recordAudio(){
    if (!audioRecorder.recording)
    {
        [audioRecorder record];
    }
}

void AudiosPlugin::playAudio() {
    
    if (!audioRecorder.recording)
    {
        NSError *error;
        
      
        AVAudioFile *file = [[AVAudioFile alloc] initForReading:audioRecorder.url error:nil];
        
        [playerNode scheduleFile:file atTime:nil completionHandler:^{}];
        [playerNode play];
        
        timePitch.rate = mTempo;
      
        
        if (error)
            NSLog(@"Error: %@",
                  [error localizedDescription]);
        else
            [audioPlayer play];
    }
}

void AudiosPlugin::stopAudio() {
    
    if (audioRecorder.recording)
    {
        [audioRecorder stop];
    } else if (audioPlayer.playing) {
        [audioPlayer stop];
    }
}

void AudiosPlugin::setTempo(float tempo) {
    mTempo = tempo;
    
    
    NSLog(@"Tempo Val: %f", tempo);
    
}

bool AudiosPlugin::isRecording() {
    return audioRecorder.recording;
}


AudiosPlugin::AudiosPlugin() {
    NSLog(@"initialize object");
}

AudiosPlugin::~AudiosPlugin() {
    NSLog(@"deinitialize object");
}

