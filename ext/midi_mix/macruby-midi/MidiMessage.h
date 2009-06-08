//
//  MidiMessage.h
//  macruby-sequencer
//
//  Created by Mike Laurence on 6/2/09.
//  Copyright 2009 Mike Laurence. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MidiMessage : NSObject {
    NSArray* data;
}

@property (retain) NSArray* data;

- (id) initWithBytes:(NSArray*) bytes;

@end
