//
//  P3ViewController.m
//  MiMediaNaranja
//
//  Created by g111 DIT UPM on 18/03/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#define HEARTSIZE 80

#import "P3ViewController.h"
#import "BirthDateChooserViewController.h"
#import "LoveDateChooserViewController.h"
#import "DeathDateChooserViewController.h"

@interface P3ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *birthButton;
@property (weak, nonatomic) IBOutlet UIButton *loveButton;
@property (weak, nonatomic) IBOutlet UIButton *deathButton;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIImageView *HeartContainer;
@end

@implementation P3ViewController


-(NSString *) formatDate: (NSDate *) date{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString * dateFormated = [dateFormat stringFromDate:date];
    return dateFormated;
}

- (void) showAlert: (NSString *) msg withTitle: (NSString *) title hideResults:(BOOL) hideres{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [message show];
    if (hideres) {
        self.loveDate = nil;
        [self.resultLabel setText:@""];
        self.HeartContainer.hidden = YES;
        [self.loveButton setTitle:@"Elegir Fecha" forState:UIControlStateNormal];
    }
}

- (void) setHeartImage:(CGFloat) part {
    UIImage* img = [UIImage imageNamed:@"Heart.png"];
    CGFloat width = part * HEARTSIZE;
    CGRect imgFrame = CGRectMake(0, 0, width, HEARTSIZE);
    CGImageRef imageRef = CGImageCreateWithImageInRect([img CGImage], imgFrame);
    UIImage* subImage = [UIImage imageWithCGImage: imageRef];
    [self.HeartContainer setImage: subImage];
    self.HeartContainer.hidden = NO;
    CGImageRelease(imageRef);
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // Since this view shouldn't unload, we place this here to run
    // the check every time we return from a segue
    if(self.birthDate==nil || self.deathDate==nil){
        [self.loveButton setEnabled:NO];
    } else {
        [self.loveButton setEnabled:YES];
    }

    if(self.birthDate!=nil && self.deathDate!=nil && self.loveDate != nil){
        CGFloat total = [self.deathDate timeIntervalSince1970] - [self.birthDate timeIntervalSince1970];
        CGFloat love = [self.loveDate timeIntervalSince1970] - [self.birthDate timeIntervalSince1970];
        // Not sure wich one is the correct one, I think the first one
        CGFloat perc = (total - love) / total;
        
        if (perc > 0 && perc <= 1 ) {
        //CGFloat perc = love / total;
        [self.resultLabel setText: [NSString stringWithFormat:@"%.2f%%",perc*100]];
        [self setHeartImage:perc];
        [self.HeartContainer setNeedsDisplay];
        } else {
            // This shouldn't happen, but sometimes the dates don't check properly
            [self showAlert:@"Alguna de las fechas que has marcado no encaja. ¡Revisalas!" withTitle:@"¡Fechas invalidas!" hideResults:YES];
            
        }
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"selectBirth"]){
        BirthDateChooserViewController * vc = segue.destinationViewController;
        vc.birthDate = self.birthDate ? self.birthDate : [NSDate date];
    } else if([segue.identifier isEqualToString:@"selectLove"]){
        LoveDateChooserViewController * vc = segue.destinationViewController;
        vc.loveDate = self.loveDate ? self.loveDate : [NSDate date];
        vc.birthDate = self.birthDate ? self.birthDate : [NSDate date];
        vc.deathDate = self.deathDate ? self.deathDate : [NSDate date];
    } else if([segue.identifier isEqualToString:@"selectDeath"]){
        DeathDateChooserViewController * vc = segue.destinationViewController;
        vc.deathDate = self.deathDate ? self.deathDate : [NSDate date];
    }
}

-(IBAction)birthSelected:(UIStoryboardSegue *)segue{
    if([segue.identifier isEqualToString:@"okBirth"]){
        BirthDateChooserViewController * vc = segue.sourceViewController;
        self.birthDate = vc.birthDate;
        NSString * dateFormated = [self formatDate:self.birthDate];
        [self.birthButton setTitle: dateFormated forState:UIControlStateNormal];
        
        if (self.loveDate != nil && self.loveDate < self.birthDate) {
            // The loveDate cannot be greater than the death date, so we alert the user and
            // reset the results
            [self showAlert:@"La fecha de enamoramiento es menor que la de nacimiento. Por favor, actualizala" withTitle:@"¡Fecha de enamoramiento invalida!" hideResults:YES];
        }
    }
}

-(IBAction)birthCanceled:(UIStoryboardSegue *)segue{
    
}

-(IBAction)loveSelected:(UIStoryboardSegue *)segue{
    if([segue.identifier isEqualToString:@"okLove"]){
        LoveDateChooserViewController * vc = segue.sourceViewController;
        self.loveDate = vc.loveDate;
        NSString * dateFormated = [self formatDate:self.loveDate];
        [self.loveButton setTitle: dateFormated forState:UIControlStateNormal];
    }
}

-(IBAction)loveCanceled:(UIStoryboardSegue *)segue{
    
}

-(IBAction)deathSelected:(UIStoryboardSegue *)segue{
    if([segue.identifier isEqualToString:@"okDeath"]){
        DeathDateChooserViewController * vc = segue.sourceViewController;
        self.deathDate = vc.deathDate;
        NSString * dateFormated = [self formatDate:self.deathDate];
        [self.deathButton setTitle: dateFormated forState:UIControlStateNormal];
    
        if (self.loveDate != nil && self.loveDate > self.deathDate) {
            // The loveDate cannot be greater than the death date, so we alert the user and
            // reset the results
            [self showAlert:@"La fecha de enamoramiento es mayor que la de muerte. Por favor, actualizala" withTitle:@"¡Fecha de enamoramiento invalida!" hideResults: YES];
        }
    }
}

-(IBAction)deathCanceled:(UIStoryboardSegue *)segue{
    
}

@end
