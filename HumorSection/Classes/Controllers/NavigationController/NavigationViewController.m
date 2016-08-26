//
//  NavigationViewController.m
//  HumorSection
//
//  Created by 洋洋 on 16/7/13.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "MainViewController.h"
#import "NavigationViewController.h"
#import "MeirijingxunViewController.h"
#import "ShipinViewController.h"
#import "DuanziViewController.h"
#import "GerenzhongxinViewController.h"


@interface NavigationViewController ()
@end

@implementation NavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}
// 第一次用这个类的时候调用这个方法
+ (void)initialize
{
    // 调用UINavigationBar对象的appearance类方法返回了一个UINavigationBar对象,这个对象可以控制整个项目中这个对象对应的默认样式
    UINavigationBar *navBar = [UINavigationBar appearance];
    // 只有方法或者属性之后有标识:UI_APPEARANCE_SELECTOR的属性或者方法才可以在这里设置
    [navBar setBarTintColor:[UIColor orangeColor]];
    [navBar setTintColor:[UIColor blackColor]];
 
}

@end
