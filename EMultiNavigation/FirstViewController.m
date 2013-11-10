//
//  FirstViewController.m
//  EMultiNavigation
//
//  Created by EasonWang on 13-11-5.
//  Copyright (c) 2013年 EasonWang. All rights reserved.
//

#import "FirstViewController.h"
//#import "RootViewController.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        setViewBounds(self);
        NSArray *nibArray = [[NSBundle mainBundle]loadNibNamed:@"EMNavigateView" owner:self options:nil];
        EMNavigateView *EMNView = nibArray[0];
        NSLog(@"%f",self.view.bounds.origin.y);
        [EMNView setFrame:CGRectMake(0,-20, 320, 64)];
        [EMNView setBackgroundColor:[UIColor redColor]];
        EMNView.button.hidden = YES;
        [self.view addSubview:EMNView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 280, 280)];
    label.text = [NSString stringWithFormat:@"%d",RootNavigationController.viewControllers.count];
    label.font = [UIFont systemFontOfSize:250];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(50, 240, 220, 50)];
    [button setBackgroundColor:[UIColor grayColor]];
    [button setTitle:@"Push a new controller" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [EMNavigateView instance].title.text = @"first";
    
    UILabel *textView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 180)];
    textView.font = [UIFont systemFontOfSize:12];
    textView.text = @"MultiLayerNavigation helps you implemntation the interaction -- 'drag to back' in a easy way.\n The only one thing you need to do is replacing your UINavigationController with the MLNavigation Controller or inherit it.";
    textView.numberOfLines = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)pressBtn:(UIButton *)sender
{
    SecondViewController *vc = [[SecondViewController alloc]initWithNibName:@"SecondViewController" bundle:nil];
    [RootNavigationController pushViewController:vc animated:YES];
}

@end
