//
//  EventsManager.m
//  AOC2Work3
//
//  Created by Will Saults on 12/1/12.
//  Copyright (c) 2012 Fullsail. All rights reserved.
//

#import "EventsManager.h"

@implementation EventsManager {
    
}

static EventsManager *sharedEventsManager;

#pragma mark - Class level methods
+(EventsManager *)sharedEventsManager {
    @synchronized(self) {
        if(!sharedEventsManager) {
            [self new];
        }
    }
    return sharedEventsManager;
}

+(id)alloc {
    @synchronized(self) {
        NSAssert(sharedEventsManager == nil, @"Attempted second allocation of singleton");
        sharedEventsManager = [super alloc];
    }
    return sharedEventsManager;
}

-(id)init {
    self = [super init];
    if (self != nil) {
        _savedEvents = [NSMutableArray new];
    }
    return sharedEventsManager;
}

@end
