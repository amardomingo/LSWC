//
//  P2ViewController.m
//  P2AngryBirds
//
//  Created by g111 DIT UPM on 25/02/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import "P2ViewController.h"

@interface P2ViewController ()
@end



@implementation P2ViewController

- (IBAction)changeSpeed:(UISlider *)sender {
    self.model.initialSpeed = sender.value;
}

- (IBAction)changeAngle:(UISlider *)sender {
    self.model.initialAngle = sender.value;
}

- (IBAction)changeDistance:(UISlider *)sender {
    self.model.targetDistance = sender.value;
}

-(P2ParabolicModel * ) model{
    if(_model){
        _model = [[P2ParabolicModel alloc] init];
    }
    return _model;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
