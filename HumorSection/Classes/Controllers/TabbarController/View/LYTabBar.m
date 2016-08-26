//
//  LYTabBar.m
//  HumorSection
//
//  Created by 洋洋 on 16/7/18.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "LYTabBar.h"

@implementation LYTabBar
{
    __weak UIButton *_btnPlus;
}

/** 纯代码方式创建当前视图的时候会调用这个方法 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //[self loadDefaultSetting];
    }
    return self;
}

/** 从xib文件加载的时候会调用这个方法 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        //[self loadDefaultSetting];
    }
    return self;
}
// 布局子视图就会调用此方法, 系统调用, 会调用多次
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 取出当前所有的UITabBarButton
    NSArray *arrViews = self.subviews;
    //NSLog(@"%@", arrViews);
    // 遍历所有的子视图, 过滤出所有的UITabBarButton
    NSUInteger count = arrViews.count;
    NSMutableArray *arrTabBarButtons = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger index = 0; index < count; index ++)
    {
        UIView *view = arrViews[index];
        Class clsView = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:clsView])
        {
            [arrTabBarButtons addObject:view];
        }
    }
    // 布局所有的UITabBarButton
    NSUInteger itemCount = arrTabBarButtons.count;
    CGFloat itemWidth = self.frame.size.width /itemCount;
    CGFloat itemHeight = self.frame.size.height;
    for (NSUInteger index = 0; index < itemCount; index ++)
    {
        CGFloat itemX = 0;
        itemX = index * itemWidth;
        // view实际上就是一个UITabBarButton类型的view
        UIView *view = arrTabBarButtons[index];
        view.frame = CGRectMake(itemX, 0, itemWidth, itemHeight);
    }
    // 布局btnPlus
    _btnPlus.frame = CGRectMake(itemCount/2 * itemWidth, 0, itemWidth, itemHeight);
}

@end
