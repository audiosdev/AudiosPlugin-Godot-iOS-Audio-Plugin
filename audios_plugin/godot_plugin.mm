//
//  godot_plugin.m
//  godot_plugin
//
//  Created by Audiosdroid on 07.06.2022.
//  Copyright © 2022 Godot. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "godot_plugin.h"
#import "godot_plugin_implementation.h"

#import "core/engine.h"

AudiosPlugin *plugin;

void godot_plugin_init() {
    NSLog(@"init plugin");

    plugin = memnew(AudiosPlugin);
    Engine::get_singleton()->add_singleton(Engine::Singleton("AudiosPlugin", plugin));
    

}

void godot_plugin_deinit() {
    NSLog(@"deinit plugin");
    
    if (plugin) {
       memdelete(plugin);
   }
}
