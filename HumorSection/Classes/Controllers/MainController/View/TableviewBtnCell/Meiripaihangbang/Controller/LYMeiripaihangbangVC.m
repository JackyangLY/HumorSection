//
//  LYMeiripaihangbangVC.m
//  HumorSection
//
//  Created by 洋洋 on 16/7/20.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "LYMeiripaihangbangVC.h"
#import "LYScrollPageView.h"
#import "LYShenhuifuController.h"
#import "LYMimiViewController.h"
#import "LYGIFtuViewController.h"
#import "LYMengchongjizhongying.h"
#import "LYLengxiaohuaViewController.h"

@implementation LYMeiripaihangbangVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadBasicSetting];
}
#pragma mark 加载默认设置
-(void)loadBasicSetting
{
    UILabel *labeltitle = [[UILabel alloc]initWithFrame:CGRectMake(self.view.center.x-35, 30, 100, 30)];
    labeltitle.text = @"每日排行榜";
    [self.view addSubview:labeltitle];
    [self.view setBackgroundColor:[UIColor orangeColor]];
    UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backbutton setImage:[UIImage imageNamed:@"主页white32x32"] forState:UIControlStateNormal];
    backbutton.frame = CGRectMake(10,28, LYSCREEN_WIDTH*0.085, LYSCREEN_WIDTH*0.085);
    [backbutton addTarget:self action:@selector(dissmissViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbutton];
    
    [self addViewController];
}
-(void)addViewController
{
    LYShenhuifuController *shenhuifuVc = [[LYShenhuifuController alloc]init];
    LYMimiViewController *mmVC=[[LYMimiViewController alloc]init];
    LYGIFtuViewController *gifVC=[[LYGIFtuViewController alloc]init];
    LYMengchongjizhongying *mcjzyVC=[[LYMengchongjizhongying alloc]init];
    LYLengxiaohuaViewController *lxhVc=[[LYLengxiaohuaViewController alloc]init];
    LYScrollPageView *scrollPageview=[[LYScrollPageView alloc]initWithFrame:CGRectMake(0, 70, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-73) controllers:@[shenhuifuVc,mmVC,gifVC,mcjzyVC,lxhVc] names:@[@"神回复",@"秘密",@"GIF图",@"萌宠联盟",@"冷笑话"]];

    [self.view addSubview:scrollPageview];
}

-(void)dissmissViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
