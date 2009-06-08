//
//  MidiReceiver.m
//  laurence-live-macruby
//
//  Created by Mike Laurence on 5/26/09.
//  Copyright 2009 Mike Laurence. All rights reserved.
//

#include <CoreMIDI/CoreMIDI.h>
#import <MidiMessenger.h>
#import <MidiMessage.h>

@interface MidiReceiver : MidiMessenger {
    NSMutableArray* data;
}

- (void) processMIDIPacketList: (MIDIPacketList*) myPacketList sender:(id)sender;
- (void) processMIDIPacket: (MIDIPacket*) packet;

- (NSArray*) newData;

@end


@implementation MidiReceiver

- (id) init {
    data = [NSMutableArray new];
    return self;
}

- (void) setPort:(PYMIDIEndpoint*) newPort {
    [self releasePort];
    
    // Assign new port and add self as receiver
    port = newPort;
    [port addReceiver:self];
}

- (void) releasePort {
    // Release self as sender if a port is already in use
    if (port)
        [port removeReceiver:self];
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
