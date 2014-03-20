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
@property (weak, nonatomic) IBOutlet UIButton *birthButton;
@property (weak, nonatomic) IBOutlet UIButton *meetButton;
@property (weak, nonatomic) IBOutlet UIButton *deathButton;


@end

@implementation P3ViewController

-(NSString *) formatDate: (NSDate *) date{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString * dateFormated = [dateFormat stringFromDate:date];
    //printf("%s",dateFormated);
    return dateFormated;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"selectBirth"]){
        BirthDateChooserViewController * bdvc = segue.destinationViewController;
        bdvc.birthDate = self.birthDate ? self.birthDate : [NSDate date];
    }
}

-(IBAction)birthSelected:(UIStoryboardSegue *)segue{
    if([segue.identifier isEqualToString:@"okBirth"]){
        BirthDateChooserViewController * bdvc = segue.sourceViewController;
        self.birthDate = bdvc.birthDate;
        //NSLog(@"%@",self.birthDate==nil ? @"YES" : @"NO");
        NSString * dateFormated = [self formatDate:self.birthDate];
        //printf("%s",dateFormated);
        [self.birthButton setTitle: dateFormated forState:UIControlStateNormal];
    }
}

-(IBAction)birthCanceled:(UIStoryboardSegue *)segue{
    
}



@end
