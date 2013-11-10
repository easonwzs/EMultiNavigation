//
//  EMNavigation.m
//  CoustomNavigation
//
//  Created by EasonWang on 13-10-29.
//  Copyright (c) 2013年 EasonWang. All rights reserved.
//

#define KEY_WINDOW [[UIApplication sharedApplication]keyWindow]
#define ONE_CONTROLLER (self.viewControllers.count<=1)

#import "EMNavigation.h"
#import "TabBarView.h"
@interface EMNavigation ()
{
    CGPoint startTouch;
    UIImageView *lastScreenShotView;
    UIView *blackMask;
}
@property (nonatomic, retain) NSMutableArray *screenShotsList;
@property (nonatomic, retain) UIView *backGroundView;
@property (nonatomic, assign) BOOL isMoving;
@property (nonatomic, assign) BOOL isOpened;
@end

@implementation EMNavigation

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.screenShotsList = [[NSMutableArray alloc]initWithCapacity:2];
        self.navigationBar.hidden = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];


    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(paningGestureReceive:)];
    
    [panGesture delaysTouchesBegan];
    [self.view addGestureRecognizer:panGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - shot screen view
-(UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark - overwrite
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.screenShotsList addObject:[self capture]];
    [super pushViewController:viewController animated:animated];
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    [self.screenShotsList removeLastObject];
    return [super popViewControllerAnimated:animated];
}

#pragma mark - UIPanGestureRecongnizer
- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer
{
    
        // we get the touch position by the window's coordinate
        CGPoint touchPoint = [recoginzer locationInView:KEY_WINDOW];
        
        if (ONE_CONTROLLER) return;
        
        // begin paning, show the backgroundView(last screenshot),if not exist, create it.
        if (recoginzer.state == UIGestureRecognizerStateBegan) {
            NSLog(@"begin");
            _isMoving = YES;
            startTouch = touchPoint;
            
            if (!self.backGroundView)
            {
                CGRect frame = self.view.frame;
                
                self.backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
                [self.view.superview insertSubview:self.backGroundView belowSubview:self.view];
                
                blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
                blackMask.backgroundColor = [UIColor blackColor];
                [self.backGroundView addSubview:blackMask];
            }
            
            self.backGroundView.hidden = NO;
            
            if (lastScreenShotView) [lastScreenShotView removeFromSuperview];
            
            UIImage *lastScreenShot = [self.screenShotsList lastObject];
            lastScreenShotView = [[UIImageView alloc]initWithImage:lastScreenShot];
            [self.backGroundView insertSubview:lastScreenShotView belowSubview:blackMask];
            if (ONE_CONTROLLER) {
                self.backGroundView.hidden = YES;
                _isMoving = NO;
                UIImage *image = [self capture];
                lastScreenShotView = [[UIImageView alloc]initWithImage:image];
            }
            //End paning, always check that if it should move right or move left automatically
        }else if (recoginzer.state == UIGestureRecognizerStateEnded){
            NSLog(@"end");
            
            if (touchPoint.x - startTouch.x > 50)
            {
                [UIView animateWithDuration:0.3 animations:^{
                    [self moveViewWithX:320];
                } completion:^(BOOL finished) {
                    CGRect frame = self.view.frame;
                    frame.origin.x = 200;
                    if (!ONE_CONTROLLER) {
                        [self popViewControllerAnimated:NO];
                        frame.origin.x = 0;
                    }
                    self.view.frame = frame;
                    _isMoving = NO;
                }];
            }
            else
            {
                [UIView animateWithDuration:0.3 animations:^{
                    [self moveViewWithX:0];
                } completion:^(BOOL finished) {
                    _isMoving = NO;
                    self.backGroundView.hidden = YES;
                }];
            }
            return;
            
            // cancal panning, alway move to left side automatically
        }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
            
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                _isMoving = NO;
                self.backGroundView.hidden = YES;
            }];
            return;
        }
        // it keeps move with touch
        if (_isMoving) {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:touchPoint.x - startTouch.x];
            }];
        }
}

- (void)moveViewWithX:(float)x
{
    x = x>320?320:x;
    x = x<0?0:x;
    
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;
    float scale = (x/6400)+0.95;
    float alpha = 0.4 - (x/800);
    
    lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
    blackMask.alpha = alpha;
}

@end
