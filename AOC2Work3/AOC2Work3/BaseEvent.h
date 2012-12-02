//
//  BaseEvent.h
//  AOC2Work3
//
//  Created by Will Saults on 12/1/12.
//  Copyright (c) 2012 Fullsail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseEvent : NSObject

@property (nonatomic, strong) NSString *eventTitle;
@property (nonatomic, strong) NSDate *eventDate;
@property (nonatomic, strong) NSString *eventDescription;

-(id)initWithTitle:(NSString *)title date:(NSDate *)date description:(NSString *)description;

@end
