//
//  P2ViewController.m
//  P2AngryBirds
//
//  Created by g111 DIT UPM on 25/02/14.
//  Copyright (c) 2014 g111 DIT UPM. All rights reserved.
//

#import "P2ViewController.h"

@interface P2ViewController () <TrajectoryDatasource>
@property (strong, nonatomic) IBOutlet UIRotationGestureRecognizer *rotationGestureRecognizer;
@property (strong, nonatomic) IBOutlet UIPinchGestureRecognizer *pinchGestureRecognizer;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeGestureRecognizer;
@end



@implementation P2ViewController

- (void) rotateCannon:(CGFloat) angle {
    self.creeperCannon.transform = CGAffineTransformMakeRotation( - angle);
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

- (IBAction)processPinchGesture:(UIPinchGestureRecognizer *)sender {
    
    self.model.initialSpeed = self.model.initialSpeed*sender.scale;
    [self checkHit];
    [self.trajView setNeedsDisplay];
    sender.scale = 1;
}


- (IBAction)processRotationGesture:(UIRotationGestureRecognizer *)sender {
    self.model.initialAngle -= M_PI_2 *sender.rotation;
    [self checkHit];
    [self.creeperCannon setNeedsDisplay];
    [self.trajView setNeedsDisplay];
    sender.rotation = 0;
}

- (IBAction)processPanGesture:(UIPanGestureRecognizer *)sender {
    CGPoint p = [sender translationInView:self.view];
    [self updateDistanceBounds];
    self.model.targetDistance += p.x;
    [sender setTranslation: CGPointZero inView: sender.view];
    [self updateDistance];
}
- (IBAction)process1TapGesture:(UITapGestureRecognizer *)sender {
    self.model.zoom += 20;
    [self.trajView setNeedsDisplay];
}
- (IBAction)process2TapGesture:(UITapGestureRecognizer *)sender {
    self.model.zoom -= 20;
    [self.trajView setNeedsDisplay];
}

- (void) loadView{
    [super loadView];
    self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    [self updateDistance];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.trajView.datasource=self;
    
    self.swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionUp;
    /*
    CGFloat anchorX = -0.01;//-self.creeperCannon.bounds.size.width/2;
    CGFloat anchorY = -00,00;//-self.creeperCannon.bounds.size.height/2;
    self.creeperCannon.layer.anchorPoint = CGPointMake(anchorX, anchorY);
*/
    //[self processRotationGesture: self.rotationGestureRecognizer];
    
    self.model.zoom = 100;
    
    //printf("%f, %f ", self.creeperCannon.frame.origin.x, self.creeperCannon.frame.origin.y );

    self.model.initialAngle = M_PI_4;
    self.model.initialSpeed = 40;
    [self updateDistanceBounds];
    self.model.targetDistance = 100;
    [self updateDistance];
    
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
   // printf("%f, %f ", self.creeperCannon.frame.origin.x, self.creeperCannon.frame.origin.y );
    [self updateDistanceBounds];
    self.model.targetDistance = self.model.maxTargetDistance - self.targetImage.bounds.size.width;
    [self updateDistance];
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

-(void) updateDistance{
    CGFloat h = self.trajView.bounds.size.height - self.targetImage.bounds.size.height/2;
    [self.targetImage setCenter:CGPointMake(self.model.targetDistance, h)];
    [self checkHit];
    [self.trajView setNeedsDisplay];
    [self.targetImage setNeedsDisplay];
}

-(void) updateDistanceBounds{    
    self.model.maxTargetDistance = self.trajView.bounds.size.width - self.targetImage.bounds.size.width/2;
}


@end
