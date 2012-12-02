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

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Data Source
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5; // TODO: depends on the number of events.
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EventCell" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor colorWithRed:237 green:237 blue:237 alpha:.5]];
    
    // Event details
    StandardEvent *event = (StandardEvent *)[EventFactory createNewEventWithTitle:@"Title" date:[NSDate date] description:@"Description"];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 20)];
    [title setText:[event eventTitle]];
    
    UILabel *description = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, cell.frame.size.width, 20)];
    [description setText:[event eventDescription]];
    
    UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, cell.frame.size.width, 20)];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
//    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"EEEE MM/dd/yyyy hh:mm a"];
    [date setText:[dateFormatter stringFromDate:[event eventDate]]];
    
    [cell addSubview:title];
    [cell addSubview:description];
    [cell addSubview:date];
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark - UICollectionView Delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: do something when the user selects a cell.
}

@end
