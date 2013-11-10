//
//  RootViewController.m
//  EMultiNavigation
//
//  Created by EasonWang on 13-11-5.
//  Copyright (c) 2013年 EasonWang. All rights reserved.
//


#define SELECTED_VIEW_CONTROLLER_TAG 98456345

#import "RootViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "EMNavigation.h"
@interface RootViewController ()

@end

@implementation RootViewController

static RootViewController *rootVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    rootVC = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return rootVC;
}
+(RootViewController *)instance
{
    return rootVC;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, 20, self.view.frame.size.width, self.view.frame.size.height)];
    _arrayViewControllers = [self getViewcontrollers];
    
    tabbar = [[TabBarView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-49, 320, 49) viewControllers:_arrayViewControllers backColor:nil Alpha:0.8f setDelegate:self];
    [self.view addSubview:tabbar];
    [self touchBtnAtIndex:0];   // setting the default viewController
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)getViewcontrollers
{
    NSArray* tabBarItems = nil;
    
    FirstViewController *first = [[FirstViewController alloc]init];
    SecondViewController *second = [[SecondViewController alloc]init];
    
    tabBarItems = @[
                    @{
                        @"viewController"   :// controller
                        first,
                        @"title"            :// title
                        @"首页",
                        @"imageDefault"     :// the default image
                        @"main@2x.png",
                        @"imageSelected"    :// the selected image
                        @"mainClick@2x.png"
                        },
                    @{
                        @"viewController"   :// controller
                        second,
                        @"title"            :// title
                        @"second",
                        @"imageDefault"     :// the default image
                        @"myNear@2x.png",
                        @"imageSelected"    :// the selected image
                        @"myNearClick@2x.png"
                        }
                    ];
    return tabBarItems;
}
-(void)touchBtnAtIndex:(NSInteger)index
{
    UIView* currentView = [self.view viewWithTag:SELECTED_VIEW_CONTROLLER_TAG];
    [currentView removeFromSuperview];
    
    NSDictionary* data = _arrayViewControllers[index];
    
    UIViewController *viewController = data[@"viewController"];
    viewController.view.tag = SELECTED_VIEW_CONTROLLER_TAG;
    
    viewController.view.frame = CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height);
    [self.view insertSubview:viewController.view belowSubview:tabbar];
}
@end
