//
//  P2TrayectoryView.h
//  P2AngryBirds
//
//  Created by g111 DIT UPM on 25/02/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class P2TrayectoryView;

@protocol TrajectoryDatasource

-(CGFloat) trajViewStartTime:(P2TrayectoryView *)tv;
-(CGFloat) trajViewEndTime:(P2TrayectoryView *)tv;
-(CGFloat) trajViewZoom:(P2TrayectoryView *)tv;
-(CGFloat) trajView:(P2TrayectoryView *)tv heightAt:(CGFloat)time;
-(CGFloat) trajView:(P2TrayectoryView *)tv distanceAt:(CGFloat)time;


@end

@interface P2TrayectoryView : UIView
@property(nonatomic,weak) id<TrajectoryDatasource> datasource;
@end

