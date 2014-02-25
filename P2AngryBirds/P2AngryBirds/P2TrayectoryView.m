//
//  P2TrayectoryView.m
//  P2AngryBirds
//
//  Created by g111 DIT UPM on 25/02/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import "P2TrayectoryView.h"

@implementation P2TrayectoryView


- (void)drawRect:(CGRect)rect
{
    UIBezierPath *traj = [UIBezierPath bezierPath];
    [traj moveToPoint:CGPointMake(0, 0)];
    CGFloat posX = 0;
    CGFloat posY = 0;
    for(CGFloat t = 0; t<10; t+=0.1){
        posX+=5; posY+=3;
        [traj addLineToPoint:CGPointMake(posX, posY)];
    }
    [traj setLineWidth:3];
    [[UIColor redColor] set];
    [traj stroke];
}


@end
