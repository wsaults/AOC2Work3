//
//  BaseEvent.m
//  AOC2Work3
//
//  Created by Will Saults on 12/1/12.
//  Copyright (c) 2012 Fullsail. All rights reserved.
//

#import "BaseEvent.h"

@implementation BaseEvent

-(id)initWithTitle:(NSString *)title date:(NSDate *)date description:(NSString *)description {
    self = [super init];
    if (self != nil) {
        _eventTitle = title;
        _eventDate = date;
        _eventDescription = description;
    }
    return self;
}

@end
