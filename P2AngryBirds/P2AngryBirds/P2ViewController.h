//
//  P2ViewController.h
//  P2AngryBirds
//
//  Created by g111 DIT UPM on 25/02/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P2ParabolicModel.h"
#import "P2TrayectoryView.h"

@interface P2ViewController : UIViewController
//@property (nonatomic, strong) P2ParabolicModel *model;
@property (strong, nonatomic) IBOutlet P2ParabolicModel *model;
@property (weak, nonatomic) IBOutlet P2TrayectoryView *trajView;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
@property (weak, nonatomic) IBOutlet UISlider *angleSlider;
@property (weak, nonatomic) IBOutlet UISlider *distanceSlider;
@property (weak, nonatomic) IBOutlet UISlider *zoomSlider;
@property (weak, nonatomic) IBOutlet UIImageView *targetImage;
-(P2ParabolicModel * ) model;
@end
