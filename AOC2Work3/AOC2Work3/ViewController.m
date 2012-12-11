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
#import "Definitions.h"
#import <QuartzCore/QuartzCore.h>


@interface ViewController () {
    IBOutlet UIView *slideBarContainer;
    IBOutlet UIView *slideBar;
    BOOL okToMoveSlideBar;
}

@end

@implementation ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [slideBarContainer.layer setCornerRadius:10.0f];
    [slideBar.layer setCornerRadius:10.0f];
    
	[self.eventCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"EventCell"];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.eventCollectionView reloadData];
    okToMoveSlideBar = NO;
    [self saveEvents:nil];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Data Source
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return ([[[EventsManager sharedEventsManager] savedEvents] count] > 0) ? [[[EventsManager sharedEventsManager] savedEvents] count] : 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EventCell" forIndexPath:indexPath];
    // Clear out any cells from the last load.
    for(UIView *subView in [cell subviews]) {
        [subView removeFromSuperview];
    }
    
    [cell setBackgroundColor:[UIColor colorWithRed:150 green:150 blue:150 alpha:.7]];
    [cell.layer setCornerRadius:5.0f];
    
    // Event details
    if ([[[EventsManager sharedEventsManager] savedEvents] count] > 0) {
        
        id event = [[[EventsManager sharedEventsManager] savedEvents] objectAtIndex:indexPath.row];
        
        // Title
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, kEventElementPadding, cell.frame.size.width, 20)];
        [title setText:[event eventTitle]];
        [title setTextAlignment:NSTextAlignmentCenter];
        [title setFont:[UIFont boldSystemFontOfSize:18]];
        [title setBackgroundColor:[UIColor clearColor]];
        
        // Description
        UILabel *description = [[UILabel alloc] initWithFrame:CGRectMake(kEventElementPadding, 30, cell.frame.size.width, 20)];
        [description setText:[event eventDescription]];
        [description setNumberOfLines:3];
        [description setBackgroundColor:[UIColor clearColor]];
        
        // Date
        UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(kEventElementPadding, 55, cell.frame.size.width, 20)];
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"EEEE MM/dd/yyyy hh:mm a"];
        [date setText:[dateFormatter stringFromDate:[event eventDate]]];
        [date setBackgroundColor:[UIColor clearColor]];
        
        // Add the subviews
        [cell addSubview:title];
        [cell addSubview:description];
        [cell addSubview:date];
        
    } else {
        // If there are no saved events...
        StandardEvent *event = (StandardEvent *)[EventFactory createNewEventWithTitle:@"No saved events." date:nil description:nil];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, kEventElementPadding, cell.frame.size.width, 20)];
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

#pragma mark - Touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:slideBar];
    if (CGRectContainsPoint(slideBar.bounds, touchPoint)) { // Look for touches that are within the bounds of the sliderBar.
        okToMoveSlideBar = YES;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if (okToMoveSlideBar) {
        if (slideBar.frame.origin.x >= kSlideBarStartX && slideBar.frame.origin.x < kSlideBarEndX) {
            
            // Animate back to original position to add resistance.
            [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                [slideBar setFrame:CGRectMake(kSlideBarStartX, kSlideBarY, slideBar.frame.size.width, slideBar.frame.size.height)];
            } completion:nil];
            
            // Set the center of the sliderBar then set the Y origin so it does not go up or down.
            slideBar.center = [touch locationInView:slideBarContainer];
            [slideBar setFrame:CGRectMake(slideBar.frame.origin.x, kSlideBarY, slideBar.frame.size.width, slideBar.frame.size.height)];
            // If the slideBar is too far left...
            if (slideBar.frame.origin.x < kSlideBarStartX) {
                [slideBar setFrame:CGRectMake(kSlideBarStartX, kSlideBarY, slideBar.frame.size.width, slideBar.frame.size.height)];
            }
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // If the slideBar is too far left...
    if (slideBar.frame.origin.x <= kSlideBarStartX) {
        [slideBar setFrame:CGRectMake(kSlideBarStartX, kSlideBarY, slideBar.frame.size.width, slideBar.frame.size.height)];
    }
    
    // If the slideBar has moved...
    if (slideBar.frame.origin.x > kSlideBarStartX) {
        if (slideBar.frame.origin.x > kSlideBarEndX) {
            // Segue to the add event controller.
            [self performSegueWithIdentifier:@"addEventSeg" sender:self];
        }
        
        // Reset the slidebar.
        [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            [slideBar setFrame:CGRectMake(kSlideBarStartX, kSlideBarY, slideBar.frame.size.width, slideBar.frame.size.height)];
        } completion:^(BOOL finished){
            okToMoveSlideBar = NO;
        }];
    }
}

-(IBAction)saveEvents:(id)sender {
    NSMutableArray *eventsToSave = [[NSMutableArray alloc] initWithCapacity:[EventsManager sharedEventsManager].savedEvents.count + 1];
    for (BaseEvent *e in [[EventsManager sharedEventsManager] savedEvents]) {
        NSMutableDictionary *dictionary = [NSMutableDictionary new];
        [dictionary setObject:e.eventTitle forKey:@"EVENT_TITLE"];
        [dictionary setObject:e.eventDescription forKey:@"EVENT_DESCRIPTION"];
        [dictionary setObject:[NSString stringWithFormat:@"%@", e.eventDate] forKey:@"EVENT_DATE"];
        
        [eventsToSave addObject:dictionary];
    }
    
    if (eventsToSave != nil) {
        // Save the user defaults.
        NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
        [standardDefaults setObject:eventsToSave forKey:kSavedEventsKey];
        [standardDefaults synchronize];
    }
}

@end
