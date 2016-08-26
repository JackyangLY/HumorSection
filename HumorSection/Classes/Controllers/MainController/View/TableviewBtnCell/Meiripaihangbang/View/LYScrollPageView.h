//
//  LYScrollPageView.h
//  SScroll
//
//  Created by  on 16/7/15.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYPageHeaderView.h"


@protocol LYScrollPageViewDelegate <NSObject>

-(void)LYDidEndDeceleratingCurrentPage:(NSInteger)currentPage;

@end

@interface LYScrollPageView : UIView<UIScrollViewDelegate,pageHeaderBtnDelegate>

//header
@property(nonatomic,strong,nullable)LYPageHeaderView *headerView;
//下面的视图
@property(nullable,nonatomic,strong)UIScrollView *scrollview;
//当前第几个view
@property(nonatomic,assign)NSInteger currentPage;

@property(nullable,nonatomic,weak)id<LYScrollPageViewDelegate> delegate;

/**加载的view的控制器viewcontroller*/
@property(nullable, nonatomic,copy) NSArray<__kindof UIViewController *> *viewControllers;

- (nullable instancetype)initWithFrame:(CGRect)frame controllers:(NSArray<__kindof UIViewController *> * __nullable)viewControllers names:(NSArray<__kindof NSString *> * __nullable)names;

@end
