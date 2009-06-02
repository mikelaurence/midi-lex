//
//  MidiSender.m
//  macruby-sequencer
//
//  Created by Mike Laurence on 6/2/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <MacRuby/MacRuby.h>
#import <Cocoa/Cocoa.h>
#include <CoreMIDI/CoreMIDI.h>
#include <PYMIDI/PYMIDI.h>

@interface MidiSender : NSObject {
    PYMIDIEndpoint* port;
}

@property (retain) PYMIDIEndpoint* port;

- (void) message: (NSArray*) data;

@end


@implementation MidiSender

- (PYMIDIEndpoint*) port {
    return port;
}

- (void) setPort:(PYMIDIEndpoint*) newPort {
    // Release self as sender if a port is already in use
    if (port)
        [port removeSender:self];
    
    // Assign new port and add self as sender
    port = newPort;
    [port addSender:self];
}

- (void) message: (NSArray*) data {
           
    int length = [data count];
    
    // Create byte array using supplied data
    Byte bytes[length];
    int i;
    for (i = 0; i < length; i++) {
        bytes[i] = [[data objectAtIndex:i] intValue];
        NSLog(@"%@", [data objectAtIndex:i]);
    }

    // Create MIDI packet list to be sent out
    Byte packetBytes[sizeof(UInt32) + sizeof(MIDITimeStamp) + sizeof(length) + length];
    MIDIPacketList* packetList = (MIDIPacketList*) packetBytes;
    MIDIPacket* packet = MIDIPacketListInit(packetList);
    packet = MIDIPacketListAdd(packetList, sizeof(packetBytes), packet, 0, length, bytes);

    // Send MIDI packet list
    [port processMIDIPacketList:packetList sender:self];
}

@end
