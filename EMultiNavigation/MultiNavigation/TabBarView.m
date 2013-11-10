//
//  TabBarView.m
//  CoustomNavigation
//
//  Created by EasonWang on 13-11-4.
//  Copyright (c) 2013年 EasonWang. All rights reserved.
//

#import "TabBarView.h"

@implementation TabBarView

static TabBarView *tabbar;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
        // Initialization code
    }
    return self;
}


-(TabBarView *)initWithFrame:(CGRect)frame viewControllers:(NSArray *)controllers backColor:(UIColor*)color Alpha:(float)alpha setDelegate:(id<TabBarViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = color;
        self.alpha = alpha;
        self.tDelegate = delegate;
        arrayButton = [[NSMutableArray alloc]initWithCapacity:0];
        int VCNumber = controllers.count;
        float butWidth = 320/controllers.count;
        for (int i = 0; i<VCNumber; i++) {
            NSDictionary *dicVC = controllers[i];
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(butWidth*i, 0, butWidth, frame.size.height)];
            [button setTag:i];
            [button setImage:[UIImage imageNamed:dicVC[@"imageDefault"]] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:dicVC[@"imageSelected"]] forState:UIControlStateSelected];
            
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [arrayButton addObject:button];
            i==0?[button setSelected:YES]:[button setSelected:NO];
        }
    }
    return self;
}

-(void)buttonClick:(id)sender
{
    UIButton *button = (UIButton *)sender;
    for (UIButton *but in arrayButton) {
        if (button.tag == but.tag) {
            but.selected = YES;
            [self.tDelegate touchBtnAtIndex:button.tag];
        }else{
            but.selected = NO;
        }
    }
}


@end
