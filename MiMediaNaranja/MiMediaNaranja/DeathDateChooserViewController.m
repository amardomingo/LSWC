//
//  DeathDateChooserViewController.m
//  MiMediaNaranja
//
//  Created by g111 DIT UPM on 20/03/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import "DeathDateChooserViewController.h"

@interface DeathDateChooserViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@end

@implementation DeathDateChooserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.datePicker setMinimumDate:[NSDate date]];
    [self.datePicker setBackgroundColor:[UIColor whiteColor]];
	if(self.deathDate) self.datePicker.date = self.deathDate;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"okDeath"]){
        self.deathDate = self.datePicker.date;
    } else if([segue.identifier isEqualToString:@"cancelDeath"]){
        //nada
    }
}

@end
