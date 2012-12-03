//
//  EventsManager.h
//  AOC2Work3
//
//  Created by Will Saults on 12/1/12.
//  Copyright (c) 2012 Fullsail. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EventsManagerDeleage <NSObject>

@required
-(void)saveEvent;

@end

@interface EventsManager : NSObject

+(EventsManager *)sharedEventsManager;

@property (nonatomic, weak) id <EventsManagerDeleage> deleage;
@property (nonatomic, strong) NSMutableArray *savedEvents;

@end
