//
//  P2TrayectoryView.m
//  P2AngryBirds
//
//  Created by g111 DIT UPM on 25/02/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import "P2TrayectoryView.h"
#import "P2ViewController.h"

@implementation P2TrayectoryView


- (void)drawRect:(CGRect)rect
{
    UIBezierPath *traj = [UIBezierPath bezierPath];
    CGFloat t0 = [self.datasource trajViewStartTime:self];
    CGFloat t1 = [self.datasource trajViewEndTime:self];
    CGFloat posX = [self.datasource trajView:self distanceAt:t0];
    CGFloat posY = [self zoom:[self.datasource trajViewZoom:self]  heightToPixel:[self.datasource trajView:self heightAt:t0]];
    [traj moveToPoint:CGPointMake(posX, posY)];
    for(CGFloat t = t0; t<=t1; t+=0.001){
        posX=[self.datasource trajView:self distanceAt:t];
        posY=[self zoom:[self.datasource trajViewZoom:self] heightToPixel:[self.datasource trajView:self heightAt:t]];
        [traj addLineToPoint:CGPointMake(posX, posY)];
    }    
    [traj setLineWidth:3];
    [[UIColor redColor] set];
    [traj stroke];
}

-(CGFloat) zoom:(CGFloat) zoom heightToPixel:(CGFloat) height{
    CGFloat h = self.bounds.size.height;
    return h -  height*h/(h-zoom);
}

@end
