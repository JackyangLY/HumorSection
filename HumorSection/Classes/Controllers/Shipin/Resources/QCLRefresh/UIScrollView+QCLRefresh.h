//
//  UIScrollView+QCLRefresh.h
//  CLRefresh
//
//  Created by hezhijingwei on 16/7/15.
//  Copyright © 2016年  . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCLHeaderView.h"
#import "QCLFooterView.h"

@interface UIScrollView (QCLRefresh)

@property (nonatomic, assign) CGFloat contentInsetTop;

@property (nonatomic, assign) CGFloat contentInsetBottom;

- (QCLHeaderView *)addHeaderRefresh:(headerBeginRefresh)headerBeightRefresh;

- (QCLFooterView *)addFooterRefresh:(footerBeginRefresh)footerBeightRefresh;


- (void)endRefresh;


@end
