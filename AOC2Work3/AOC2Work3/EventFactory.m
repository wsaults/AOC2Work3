//
//  EventFactory.m
//  AOC2Work3
//
//  Created by Will Saults on 12/1/12.
//  Copyright (c) 2012 Fullsail. All rights reserved.
//

#import "EventFactory.h"

@implementation EventFactory

+(BaseEvent *)createNewEventWithTitle:(NSString *)title date:(NSDate *)date description:(NSString *)description {
    return [[StandardEvent alloc] initWithTitle:title date:date description:description];
}

@end
