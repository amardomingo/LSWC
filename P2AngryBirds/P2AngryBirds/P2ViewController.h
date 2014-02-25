//
//  P2ViewController.h
//  P2AngryBirds
//
//  Created by g111 DIT UPM on 25/02/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P2ParabolicModel.h"

@interface P2ViewController : UIViewController
@property (nonatomic, strong) P2ParabolicModel *model;
-(P2ParabolicModel * ) model;
@end
