//
//  AddEventViewController.m
//  AOC2Work3
//
//  Created by Will Saults on 12/1/12.
//  Copyright (c) 2012 Fullsail. All rights reserved.
//

#import "AddEventViewController.h"
#import "Definitions.h"
#import "EventFactory.h"

@interface AddEventViewController () {
    IBOutlet UITextField *titleTextField;
    IBOutlet UITextField *descriptionTextField;
    IBOutlet UIDatePicker *datePicker;
}

@end

@implementation AddEventViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [titleTextField setDelegate:self];
    [descriptionTextField setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - EventsManager deleage
-(void)saveEvent {
    StandardEvent *event = (StandardEvent *)[EventFactory createNewEventWithTitle:[titleTextField text] date:[datePicker date] description:[descriptionTextField text]];
    
    [[[EventsManager sharedEventsManager] savedEvents] addObject:event];
}

#pragma  mark - UITextField deleage
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];    
    return YES;
}
@end
