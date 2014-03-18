//
//  P3ViewController.m
//  MiMediaNaranja
//
//  Created by g111 DIT UPM on 18/03/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import "P3ViewController.h"
#import "BirthDateChooserViewController.h"
@interface P3ViewController ()

@end

@implementation P3ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue{
    if([segue.identifier isEqualToString:@"selectDate"]){
        BirthDateChooserViewController * bdvc = segue.destinationViewController;
        bdvc.birthDate = self.birthDate ? self.birthDate : [NSDate date];
    }
}

-(IBAction)birthSelected:(UIStoryboardSegue *)segue{
    if([segue.identifier isEqualToString:@"okBirth"]){
        BirthDateChooserViewController * bdvc = segue.sourceViewController;
        self.birthDate = bdvc.birthDate;
    }
}

-(IBAction)birthCanceled:(UIStoryboardSegue *)segue{
    
}

@end
