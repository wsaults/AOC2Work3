//
//  ViewController.m
//  AOC2Work3
//
//  Created by Will Saults on 12/1/12.
//  Copyright (c) 2012 Fullsail. All rights reserved.
//

#import "ViewController.h"
#import "EventFactory.h"
#import "EventsManager.h"
#import "BaseEvent.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
	[self.eventCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"EventCell"];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.eventCollectionView reloadData];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Data Source
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return ([[[EventsManager sharedEventsManager] savedEvents] count] > 0) ? [[[EventsManager sharedEventsManager] savedEvents] count] : 1;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EventCell" forIndexPath:indexPath];
    // Clear out any cells from the last load.
    for(UIView *subView in [cell subviews]) {
        [subView removeFromSuperview];
    }
    
    [cell setBackgroundColor:[UIColor colorWithRed:237 green:237 blue:237 alpha:.5]];
    
    // Event details
    if ([[[EventsManager sharedEventsManager] savedEvents] count] > 0) {
        
        id event = [[[EventsManager sharedEventsManager] savedEvents] objectAtIndex:indexPath.row];
        
        // Title
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 20)];
        [title setText:[event eventTitle]];
        [title setTextAlignment:NSTextAlignmentCenter];
        [title setFont:[UIFont boldSystemFontOfSize:18]];
        [title setBackgroundColor:[UIColor clearColor]];
        
        // Description
        UILabel *description = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, cell.frame.size.width, 20)];
        [description setText:[event eventDescription]];
        [description setNumberOfLines:3];
        [description setBackgroundColor:[UIColor clearColor]];
        
        // Date
        UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, cell.frame.size.width, 20)];
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"EEEE MM/dd/yyyy hh:mm a"];
        [date setText:[dateFormatter stringFromDate:[event eventDate]]];
        [date setBackgroundColor:[UIColor clearColor]];
        
        [cell addSubview:title];
        [cell addSubview:description];
        [cell addSubview:date];
    } else {
        // If there are no saved events...
        StandardEvent *event = (StandardEvent *)[EventFactory createNewEventWithTitle:@"No saved events." date:nil description:nil];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 20)];
        [title setText:[event eventTitle]];
        [title setTextAlignment:NSTextAlignmentCenter];
        [title setFont:[UIFont boldSystemFontOfSize:18]];
        [title setBackgroundColor:[UIColor clearColor]];
        
        [cell addSubview:title];
    }
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark - UICollectionView Delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Allow user to edit event when tapped.
}

@end
