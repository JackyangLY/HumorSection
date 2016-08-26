//
//  LYTabBarViewController.m
//  HumorSection
//
//  Created by 洋洋 on 16/7/18.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "LYTabBarViewController.h"
#import "NavigationViewController.h"
#import "MainViewController.h"
#import "MeirijingxunViewController.h"
#import "ShipinViewController.h"
#import "DuanziViewController.h"
#import "GerenzhongxinViewController.h"


@interface LYTabBarViewController ()

@end

@implementation LYTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadBasicSetting];
    UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backbutton setImage:[UIImage imageNamed:@"主页black32x32"] forState:UIControlStateNormal];
    CGFloat buttonWidth =  LYSCREEN_WIDTH*0.085;
    backbutton.frame = CGRectMake(8,LYSCREEN_HEIGHT - LYSCREEN_HEIGHT *0.085 -28,buttonWidth, buttonWidth);
    [backbutton addTarget:self action:@selector(dissmissViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbutton];

    
}
-(void)loadBasicSetting;
{
    MeirijingxunViewController *vcMRJX = [MeirijingxunViewController new];
    [self addViewController:vcMRJX imageName:@"精选" title:@"每日精选"];
    
    ShipinViewController *vcSP = [ShipinViewController new];
    [self addViewController:vcSP imageName:@"视频" title:@"视频"];
    
    DuanziViewController *vcDZ = [DuanziViewController new];
    [self addViewController:vcDZ imageName:@"段" title:@"段子"];
}



- (void)addViewController:(UIViewController *)viewController imageName:(NSString *)imageName title:(NSString *)title
{
    viewController.tabBarItem.image = [UIImage imageNamed:imageName];
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected", imageName]];
    viewController.title = title;
    viewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    // 创建一个导航控制器
    NavigationViewController *vcNav = [[NavigationViewController alloc] initWithRootViewController:viewController];
    // 把导航控制器添加到TanBarController中
    [self addChildViewController:vcNav];
}
-(void)dissmissViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
