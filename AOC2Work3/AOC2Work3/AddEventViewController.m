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

-(IBAction)addEvent:(id)sender;

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
    
    // Set the date picker's minimum date to today's date.
    [datePicker setMinimumDate:[NSDate date]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)addEvent:(id)sender {
    [self saveEvent];
}

#pragma mark - EventsManager deleage
-(void)saveEvent {
    StandardEvent *event = (StandardEvent *)[EventFactory createNewEventWithTitle:[titleTextField text]
                                                                             date:[datePicker date]
                                                                      description:[descriptionTextField text]];
    
    [[[EventsManager sharedEventsManager] savedEvents] addObject:event];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextField deleage
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];    
    return YES;
}
@end
