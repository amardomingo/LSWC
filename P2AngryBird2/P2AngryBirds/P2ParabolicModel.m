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
    return self.initialSpeed*sin([self initialAngle])*time-0.5*G*time*time;
}
- (CGFloat) distanceAt: (CGFloat) time{
    return self.initialSpeed*cos([self initialAngle])*time;
}
- (CGFloat) duration{
    return 2*self.initialSpeed*sin([self initialAngle])/G;
}
- (void) setInitialAngle:(CGFloat)angle{
    if (angle < M_PI_2  &&  angle > 0){
        _initialAngle = angle;
    }
}

- (void) setInitialSped:(CGFloat)speed{
    if (speed < 70  &&  speed > 5){
        _initialSpeed = speed;
    }
}

- (void) setTargetDistance:(CGFloat)targetDistance{
    if (targetDistance < self.maxTargetDistance  &&  targetDistance > 0){
        _targetDistance = targetDistance;
    }
}

-(void) setZoom:(CGFloat)zoom{
    if (zoom < 250){
        _zoom = zoom;
    }
}
@end
