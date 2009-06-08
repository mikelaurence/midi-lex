//
//  MidiMessage.m
//  laurence-live-macruby
//
//  Created by Mike Laurence on 6/1/09.
//  Copyright 2009 Mike Laurence. All rights reserved.
//

#import <MidiMessage.h>

@implementation MidiMessage

@synthesize data;

- (id) initWithBytes:(NSArray*) bytes {
    if (self = [super init])
        data = bytes;
    return self;
}


@end
