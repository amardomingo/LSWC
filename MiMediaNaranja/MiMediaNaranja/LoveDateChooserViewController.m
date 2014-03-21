//
//  LoveDateChooserViewController.m
//  MiMediaNaranja
//
//  Created by g111 DIT UPM on 20/03/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import "LoveDateChooserViewController.h"

@interface LoveDateChooserViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation LoveDateChooserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.datePicker setMinimumDate:self.birthDate];
    [self.datePicker setMaximumDate:self.deathDate];
    [self.datePicker setBackgroundColor:[UIColor whiteColor]];
	if(self.loveDate) self.datePicker.date = self.loveDate;
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"okLove"]){
        self.loveDate = self.datePicker.date;
    } else if([segue.identifier isEqualToString:@"cancelLove"]){
        //nada
    }
}


@end
