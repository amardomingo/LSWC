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

- (CGFloat) heightAt: (CGFloat) time;
- (CGFloat) distanceAt: (CGFloat) time;
- (CGFloat) duration;

@end
