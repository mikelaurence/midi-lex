//
//  MidiMessenger.h
//  macruby-midi
//
//  Created by Mike Laurence on 6/7/09.
//  Copyright 2009 Mike Laurence. All rights reserved.
//

#include <PYMIDI/PYMIDI.h>

@interface MidiMessenger : NSObject {
    PYMIDIEndpoint* port;
}

- (void) setPort:(PYMIDIEndpoint*) newPort;
- (void) releasePort;

@end

