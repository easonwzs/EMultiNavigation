//
//  SecondViewController.m
//  EMultiNavigation
//
//  Created by EasonWang on 13-11-10.
//  Copyright (c) 2013年 EasonWang. All rights reserved.
//

#import "SecondViewController.h"

#import "FirstViewController.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        setViewBounds(self);
        NSArray *nibArray = [[NSBundle mainBundle]loadNibNamed:@"EMNavigateView" owner:self options:nil];
        EMNavigateView *EMNView = nibArray[0];
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)pushBut:(id)sender
{
    FirstViewController *first = [[FirstViewController alloc]init];
    [RootNavigationController pushViewController:first animated:YES];
}

@end
