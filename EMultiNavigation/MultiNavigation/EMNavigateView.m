//
//  EMNavigateView.m
//  EMultiNavigation
//
//  Created by EasonWang on 13-11-8.
//  Copyright (c) 2013年 EasonWang. All rights reserved.
//

#import "EMNavigateView.h"

@implementation EMNavigateView
@synthesize title = _title;

static EMNavigateView *EMNView;

+(EMNavigateView *)instance
{
    if (EMNView == nil) {
        EMNView = [[EMNavigateView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        
    }
    return EMNView;
}

- (id)initWithFrame:(CGRect)frame
{
    EMNView = [super initWithFrame:frame];
    if (EMNView) {
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 44)];
        [self.title setText:@"test"];
        [EMNView addSubview:self.title];
        [self.button setTitle:@"testbut" forState:UIControlStateDisabled];
    }
    return EMNView;
}

-(IBAction)buttonClick:(id)sender
{
    NSLog(@"buttonClick");
}


@end
