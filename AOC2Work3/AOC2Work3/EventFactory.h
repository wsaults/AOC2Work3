//
//  EventFactory.h
//  AOC2Work3
//
//  Created by Will Saults on 12/1/12.
//  Copyright (c) 2012 Fullsail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEvent.h"
#import "StandardEvent.h"

@interface EventFactory : NSObject

+(BaseEvent *)createNewEventWithTitle:(NSString *)title date:(NSDate *)date description:(NSString *)description;

@end
