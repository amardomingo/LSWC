//
//  GHPView.m
//  Granja
//

#import "GHPView.h"

enum GHPState {
	GHP_I_AM_HEN,
	GHP_I_AM_EGG,
	GHP_I_AM_CHICKEN,
	GHP_I_AM_FRIED,
	GHP_I_AM_ROAST,
    GHP_I_AM_BROKEN
};

// Propiedades privadas
@interface GHPView ()

@property (nonatomic) enum GHPState ghpState;

@property (nonatomic) CGFloat scale;
@property (nonatomic) CGFloat rotation;
@property (nonatomic) CGFloat translationX;
@property (nonatomic) CGFloat translationY;

@end

@implementation GHPView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       
        self.scale = 1;
        self.rotation = 0;
        self.translationX = 0;
        self.translationY = 0;
        
        // Resize mask
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleRightMargin |
                                UIViewAutoresizingFlexibleTopMargin |
                                UIViewAutoresizingFlexibleBottomMargin;
        
        // Necesito enterarme de los eventos.
        [self setUserInteractionEnabled:YES];
        
        self.ghpState = GHP_I_AM_HEN; // Imagen inicial
        
		// Crea reconocedor de Tap para ir de gallina a huevo, a pollo, y a gallina
		UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc]
										  initWithTarget:self
										  action:@selector(processTap:)];
		[tapRec setNumberOfTapsRequired:1];
		[self addGestureRecognizer:tapRec];
		
		// Creo reconocedor de Long Press para freir huevo
		UILongPressGestureRecognizer *lpRec = [[UILongPressGestureRecognizer alloc]
											   initWithTarget:self
											   action:@selector(processLongPress:)];
		[self addGestureRecognizer:lpRec];
		
		// Crea reconocedor de Pan para mover imagen view
		UIPanGestureRecognizer *panRec = [[UIPanGestureRecognizer alloc]
										  initWithTarget:self
										  action:@selector(processPan:)];
		[self addGestureRecognizer:panRec];
		
		// Crea reconocedor de Pinch para escalar imagen view
		UIPinchGestureRecognizer *pinchRec = [[UIPinchGestureRecognizer alloc]
											  initWithTarget:self
											  action:@selector(processPinch:)];
		[self addGestureRecognizer:pinchRec];
        
    	// Crea reconocedor de Rotation para girar imagen view
		UIRotationGestureRecognizer *rotationRec = [[UIRotationGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(processRotation:)];
		[self addGestureRecognizer:rotationRec];
        
        // Crea reconocedor de Tap con dos dedos para ir de huevo a huevo roto
		UITapGestureRecognizer *doubleTapRec = [[UITapGestureRecognizer alloc]
										  initWithTarget:self
										  action:@selector(processDoubleTap:)];
		[doubleTapRec setNumberOfTapsRequired:1];
        [doubleTapRec setNumberOfTouchesRequired:2];
		[self addGestureRecognizer:doubleTapRec];

        
    }
    return self;
}

- (void) setGhpState:(enum GHPState)ghpState {  // Redefino el setter
    
	_ghpState = ghpState;
    
	switch (ghpState) {
		case GHP_I_AM_HEN:
			self.image = [UIImage imageNamed:@"gallina.png"];
			break;
		case GHP_I_AM_EGG:
			self.image = [UIImage imageNamed:@"huevo.png"];
			break;
		case GHP_I_AM_CHICKEN:
			self.image = [UIImage imageNamed:@"pollo.png"];
			break;
		case GHP_I_AM_FRIED:
			self.image = [UIImage imageNamed:@"frito.png"];
			break;
        case GHP_I_AM_ROAST:
			self.image = [UIImage imageNamed:@"asado.png"];
			break;
        case GHP_I_AM_BROKEN:
            self.image = [UIImage imageNamed:@"roto.png"];
            break;
    }
    
    self.bounds = CGRectMake(0,
                             0,
                             self.image.size.width,
                             self.image.size.height);
    [self updateAffineTransforms];
}

-(void)processTap:(UITapGestureRecognizer *)sender {
	
	switch (self.ghpState) {
		case GHP_I_AM_HEN:
			self.ghpState = GHP_I_AM_EGG;
			break;
			
		case GHP_I_AM_EGG:
			self.ghpState = GHP_I_AM_CHICKEN;
			break;
			
		case GHP_I_AM_CHICKEN:
			self.ghpState = GHP_I_AM_HEN;
			break;
            
		case GHP_I_AM_FRIED:
			break;
		case GHP_I_AM_ROAST:
			break;
        case GHP_I_AM_BROKEN:
            break;
    }
}

-(void)processDoubleTap:(UITapGestureRecognizer *)sender {
	
	switch (self.ghpState) {
		case GHP_I_AM_HEN:
			break;
			
		case GHP_I_AM_EGG:
			self.ghpState = GHP_I_AM_BROKEN;
			break;
			
		case GHP_I_AM_CHICKEN:
			break;
            
		case GHP_I_AM_FRIED:
			break;
            
		case GHP_I_AM_ROAST:
			break;
            
        case GHP_I_AM_BROKEN:
            break;

    }
}

-(void)processLongPress:(UILongPressGestureRecognizer *)sender {
	
   // NSLog(@"LP state=%i img=%i",sender.state, self.ghpState);
    
    if (sender.state != UIGestureRecognizerStateBegan) return;
    
	switch (self.ghpState) {
        case GHP_I_AM_HEN: { // Llaves necesarias en ARC para indicar ambito
            [UIView animateWithDuration:0.5
                                  delay:0
                                options:UIViewAnimationOptionTransitionFlipFromLeft
                             animations:^{
                                 self.ghpState = GHP_I_AM_ROAST;
                             }
                             completion:nil];
            
			break;
        }
        case GHP_I_AM_EGG: { // Llaves necesarias en ARC para indicar ambito
            [UIView animateWithDuration:0.5
                                  delay:0
                                options:UIViewAnimationOptionTransitionFlipFromLeft
                             animations:^{
                                 self.ghpState = GHP_I_AM_FRIED;
                             }
                             completion:nil];
            break;
        }
		case GHP_I_AM_CHICKEN:
            break;
		case GHP_I_AM_FRIED:
			break;
		case GHP_I_AM_ROAST:
			break;
        case GHP_I_AM_BROKEN:
            break;
	}
}

- (void)processPinch:(UIPinchGestureRecognizer *)sender
{
	CGFloat factor = sender.scale;
    
    self.scale *= factor ;
    sender.scale = 1;
    
    [self updateAffineTransforms];
}


- (void)processRotation:(UIRotationGestureRecognizer *)sender
{
	CGFloat angle = sender.rotation;
    
    self.rotation += angle;
    sender.rotation = 0;
    
    [self updateAffineTransforms];
}


- (void)processPan:(UIPanGestureRecognizer *)sender
{
    CGPoint pos = [sender translationInView:[sender.view superview]];
    
	self.translationX += pos.x;
    self.translationY += pos.y;
    
    [sender setTranslation:CGPointZero inView:sender.view];
    
    [self updateAffineTransforms];
}


- (void) updateAffineTransforms
{
	CGAffineTransform t1 = CGAffineTransformMakeTranslation(self.translationX, self.translationY);
    CGAffineTransform t2 = CGAffineTransformMakeRotation(self.rotation);
	CGAffineTransform t3 = CGAffineTransformMakeScale(self.scale, self.scale);
    
	self.transform = CGAffineTransformConcat(t3,CGAffineTransformConcat(t2,t1));
}


@end
