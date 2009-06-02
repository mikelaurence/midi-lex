//
//  MidiReceiver.m
//  laurence-live-macruby
//
//  Created by Mike Laurence on 5/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <MacRuby/MacRuby.h>
#include <CoreMIDI/CoreMIDI.h>
#import <MidiMessage.h>

@interface MidiReceiver : NSObject {
    NSObject* receiver;
    NSMutableArray* data;
}

- (void) processMIDIPacketList: (MIDIPacketList*) myPacketList sender:(id)sender;
- (void) processMIDIPacket: (MIDIPacket*) packet;

- (NSArray*) newData;

@end


@implementation MidiReceiver

- (id) init {
    [[MacRuby sharedRuntime] evaluateString:@"class X; def foo(x=1, *a); p 'hi Im a ruby object'; end; end"];
    Class klass = NSClassFromString(@"X");
    receiver = [klass new];
    [receiver performRubySelector:@selector(foo)];
    
    data = [NSMutableArray new];
    
    return self;
}

- (void) processMIDIPacketList: (MIDIPacketList*) myPacketList sender:(id)sender
{
    MIDIPacket* packet = &myPacketList->packet[0];
    int i;
    for (i = 0; i < myPacketList->numPackets; ++i) {
        [self processMIDIPacket: packet];
        packet = MIDIPacketNext(packet);
    }
}

- (void) processMIDIPacket: (MIDIPacket*) packet {
    if (packet->length > 0) {
        
        NSMutableArray* bytes = [NSMutableArray arrayWithCapacity:packet->length];
        int i;
        for (i = 0; i < packet->length; i++)
            [bytes insertObject: [NSNumber numberWithInt:packet->data[i]] atIndex:i];
        [data addObject:([[MidiMessage alloc] initWithBytes:bytes])];
    }
}

- (NSArray*) newData {
    if ([data count] == 0)
        return nil;
    NSArray* arr = [NSArray arrayWithArray:(data)];
    [data removeAllObjects];
    return arr;
}

@end
