//
//  MidiMessenger.m
//  macruby-midi
//
//  Created by Mike Laurence on 6/7/09.
//  Copyright 2009 Mike Laurence. All rights reserved.
//

#import <MidiMessenger.h>

@implementation MidiMessenger

- (PYMIDIEndpoint*) port {
    return port;
}

- (void) finalize {
    [self releasePort];
    NSLog(@"RELEASED ME!");
    [super finalize];
}

- (void) setPort:(PYMIDIEndpoint*) newPort {}
- (void) releasePort {}

@end
