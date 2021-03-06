//
//  P2ViewController.m
//  P2AngryBirds
//
//  Created by g111 DIT UPM on 25/02/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import "P2ViewController.h"

@interface P2ViewController () <TrajectoryDatasource>
@end



@implementation P2ViewController

- (void) rotateCannon:(CGFloat) angle {
    self.creeperCannon.transform = CGAffineTransformMakeRotation( - self.model.initialAngle);
}

-(void) checkHit{
    
    CGFloat downlimit = [self trajView:self.trajView distanceAt:self.model.duration] - 15;
    CGFloat uplimit = [self trajView:self.trajView distanceAt:self.model.duration] + 15;
    
    if(self.model.targetDistance > downlimit && self.model.targetDistance < uplimit){
        [self.targetImage setHighlighted:YES];
    }
    else {
        [self.targetImage setHighlighted:NO];
    }
    [self.targetImage setNeedsDisplay];
}

- (IBAction)changeSpeed:(UISlider *)sender {
    self.model.initialSpeed = sender.value;
    [self checkHit];
    [self.trajView setNeedsDisplay];
}

- (IBAction)changeAngle:(UISlider *)sender {
    self.model.initialAngle = sender.value;
    [self rotateCannon: sender.value];
    [self checkHit];
    [self.creeperCannon setNeedsDisplay];
    [self.trajView setNeedsDisplay];
}

- (IBAction)changeDistance:(UISlider *)sender {
    self.model.targetDistance = sender.value;
    CGFloat h = self.trajView.bounds.size.height - self.targetImage.bounds.size.height/2;
    [self.targetImage setCenter:CGPointMake(self.model.targetDistance, h)];
    [self checkHit];
    [self.trajView setNeedsDisplay];
}
- (IBAction)changeZoom:(UISlider *)sender {
    self.model.zoom = sender.value;
    [self.trajView setNeedsDisplay];
}

- (void) loadView{
    [super loadView];
    self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    [self updateDistanceSize];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.trajView.datasource=self;
    /*
    CGFloat anchorX = -0.01;//-self.creeperCannon.bounds.size.width/2;
    CGFloat anchorY = -00,00;//-self.creeperCannon.bounds.size.height/2;
    self.creeperCannon.layer.anchorPoint = CGPointMake(anchorX, anchorY);
*/
    [self changeAngle:self.angleSlider];
    [self changeSpeed:self.speedSlider];
    [self changeDistance:self.distanceSlider];
    [self changeZoom:self.zoomSlider];
    
    printf("%f, %f ", self.creeperCannon.frame.origin.x, self.creeperCannon.frame.origin.y );


    
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    printf("%f, %f ", self.creeperCannon.frame.origin.x, self.creeperCannon.frame.origin.y );

    [self updateDistanceSize];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat) trajViewStartTime:(P2TrayectoryView *)tv{
    return 0.0;
}
-(CGFloat) trajViewEndTime:(P2TrayectoryView *)tv{
    return self.model.duration;
}
-(CGFloat) trajView:(P2TrayectoryView *)tv heightAt:(CGFloat)time{
    return [self.model heightAt:time];
}
-(CGFloat) trajView:(P2TrayectoryView *)tv distanceAt:(CGFloat)time{
    return [self.model distanceAt:time];
}

-(CGFloat) trajViewZoom:(P2TrayectoryView *)tv{
    return self.model.zoom;
}

-(void) updateDistanceSize{
    CGFloat minSlider = self.trajView.bounds.size.width/2;
    [self.distanceSlider setMinimumValue: minSlider];
    CGFloat maxSlider = self.trajView.bounds.size.width - self.targetImage.bounds.size.width/2;
    [self.distanceSlider setMaximumValue: maxSlider];
    [self.distanceSlider setValue: minSlider];
    [self changeDistance:self.distanceSlider];
    [self.trajView setNeedsDisplay];
    [self.targetImage setNeedsDisplay];
}


@end
