//
//  EMNavigateView.h
//  EMultiNavigation
//
//  Created by EasonWang on 13-11-8.
//  Copyright (c) 2013年 EasonWang. All rights reserved.
//


@protocol EMNavigateViewDelegate <NSObject>

// the custom method here




@end


#import <UIKit/UIKit.h>

@interface EMNavigateView : UIView

@property(nonatomic, retain) IBOutlet UILabel *title;
@property(nonatomic, retain) IBOutlet UIButton *button;

+(EMNavigateView *)instance;

-(IBAction)buttonClick:(id)sender;
@end
