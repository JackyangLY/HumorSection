//
//  GuidePageViewController.m
//  HumorSection
//
//  Created by 洋洋 on 16/7/13.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//引导页

#import "GuidePageViewController.h"
#import "GuidescrollView.h"
@interface GuidePageViewController ()
@end

@implementation GuidePageViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadBasicSetting];
}
-(void)loadBasicSetting
{
    /**背景视图*/
    UIImageView *backImage = [UIImageView new];
    backImage.image=[UIImage imageNamed:@"相框2"];
    backImage.frame = self.view.frame;
    [self.view addSubview:backImage];
    
    /**创建导航视图*/
    GuidescrollView *guideImage =[[GuidescrollView alloc]init];
    CGFloat guideimageWidth = self.view.bounds.size.width;
    guideImage.frame = CGRectMake(0,guideimageWidth*0.25,guideimageWidth,guideimageWidth);
    [self.view addSubview:guideImage];
//    [guideImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(145);
//        make.leading.equalTo(self.view);
//        make.height.mas_equalTo(self.view.mas_width);
//        make.width.equalTo(guideImage.mas_width);
//    }];
//    
}
@end
