//
//  P2ParabolicModel.m
//  P2AngryBirds
//
//  Created by g111 DIT UPM on 25/02/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import "P2ParabolicModel.h"
#import <math.h>
#define G 9.81
@implementation P2ParabolicModel

- (CGFloat) heightAt: (CGFloat) time{
    return [self initialSpeed]*time-0.5*G*time*time;
}
- (CGFloat) distanceAt: (CGFloat) time{
    return [self initialSpeed]*time;
}
- (CGFloat) duration{
    return 2*[self initialSpeed]*sin([self initialAngle])/G;
}
@end
