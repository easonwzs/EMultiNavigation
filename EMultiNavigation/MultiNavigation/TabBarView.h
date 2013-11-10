//
//  TabBarView.h
//  CoustomNavigation
//
//  Created by EasonWang on 13-11-4.
//  Copyright (c) 2013年 EasonWang. All rights reserved.
//


// the tabbarview position
typedef enum{
    EMultiTabBarPositionLeft,   //左侧菜单栏
    EMultiTabBarPositionBottom  //底部菜单栏
}EMultiTabBarPosition;

@protocol TabBarViewDelegate <NSObject>

@required   //必须实现该方法
-(void)touchBtnAtIndex:(NSInteger)index;

@end

#import <UIKit/UIKit.h>

@interface TabBarView : UIView
{
    NSMutableArray *arrayButton;
    UIColor *_tabColor;
    
}
@property id<TabBarViewDelegate> tDelegate;


// the tabbar position
+(EMultiTabBarPosition)position;


/**
 初始化 TabBarView
 @param frame frame
 @param controllers controllers
 @param color 背景颜色
 @param alpha 透明度
 @param delegate 协议
 @returns TabBarView实例对象
 */
-(TabBarView *)initWithFrame:(CGRect)frame viewControllers:(NSArray *)controllers backColor:(UIColor*)color Alpha:(float)alpha setDelegate:(id<TabBarViewDelegate>)delegate;
@end
