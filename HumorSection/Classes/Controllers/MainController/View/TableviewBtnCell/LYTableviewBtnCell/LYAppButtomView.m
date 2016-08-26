//
//  LYAppButtomView.m
//  HumorSection
//
//  Created by 洋洋 on 16/8/9.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "LYAppButtomView.h"

#define ViewWidth self.frame.size.width
#define ViewHeight self.frame.size.height


@interface LYAppButtomView ()
/**存放button信息的数组*/
@property (nonatomic,copy)NSArray *arrInformation;
@end
@implementation LYAppButtomView
#pragma  mark 懒加载
-(NSArray *)arrInformation
{
    if (!_arrInformation)
    {
        NSURL *url = [[NSBundle mainBundle]
                      URLForResource:@"AppViewimage" withExtension:@"plist"];
        _arrInformation = [NSArray arrayWithContentsOfURL:url];
    }
    return _arrInformation;
}

/**纯代码创建时加载*/
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]  )
    {
        [self loadBasicSetting];
    }
    return self;
}
/**创建Xib时加载*/
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self loadBasicSetting];
    }
    return self;
}
/**加载默认设置UI*/
-(void)loadBasicSetting
{
    CGFloat  AppWidth = ViewWidth*0.22;
    CGFloat  AppHeight = ViewHeight*0.28;
    NSUInteger  AppLineCount = 2;
    CGFloat  AppGapX=(self.frame.size.width - AppLineCount * AppWidth) / (AppLineCount+1) ;
    CGFloat AppGapY = 15;
    NSInteger count = self.arrInformation.count;
    for (NSInteger index=0; index<count; index++)
    {
        AppViewimage *appview =[AppViewimage appView];
        
        CGFloat appX = AppGapX +(index % AppLineCount)*(AppWidth + AppGapX);
        CGFloat appY = AppGapY +(index / AppLineCount)*
        (AppHeight +AppGapY);
        appview.frame = CGRectMake(appX, appY, AppWidth, AppHeight);
        NSDictionary *dict = self.arrInformation[index];
        [appview setDictInformation:dict];
        [self addSubview:appview];
    }
    
       
}


@end
