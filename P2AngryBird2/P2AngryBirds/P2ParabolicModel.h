//
//  P2ParabolicModel.h
//  P2AngryBirds
//
//  Created by g111 DIT UPM on 25/02/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface P2ParabolicModel : NSObject
@property (nonatomic) CGFloat initialSpeed;
@property (nonatomic) CGFloat initialAngle;
@property (nonatomic) CGFloat targetDistance;
@property (nonatomic) CGFloat zoom;
@property (nonatomic) CGFloat maxTargetDistance;

- (CGFloat) heightAt: (CGFloat) time;
- (CGFloat) distanceAt: (CGFloat) time;
- (CGFloat) duration;
- (void) setInitialAngle:(CGFloat)angle;
- (void) setInitialSpeed:(CGFloat)speed;

@end
