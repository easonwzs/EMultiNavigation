//
//  RootViewController.h
//  EMultiNavigation
//
//  Created by EasonWang on 13-11-5.
//  Copyright (c) 2013年 EasonWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarView.h"
@interface RootViewController : UIViewController
<
    TabBarViewDelegate
>
{
    TabBarView *tabbar ;
}

@property (nonatomic, retain) NSArray *arrayViewControllers;

+(RootViewController *)instance;

@end
