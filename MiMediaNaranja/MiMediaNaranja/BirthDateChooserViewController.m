//
//  BirthDateChooserViewController.m
//  MiMediaNaranja
//
//  Created by g111 DIT UPM on 18/03/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import "BirthDateChooserViewController.h"

@interface BirthDateChooserViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@end

@implementation BirthDateChooserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	//self.datePicker.date = self.birthDate;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue{
    if([segue.identifier isEqualToString:@"okBirth"]){
        self.birthDate = self.datePicker.date;
    } else if([segue.identifier isEqualToString:@"cancelBirth"]){
        //nada
    }
}

@end
