//
//  UIScrollView+QCLRefresh.m
//  CLRefresh
//
//  Created by hezhijingwei on 16/7/15.
//  Copyright © 2016年  . All rights reserved.
//

#import "UIScrollView+QCLRefresh.h"
#import <objc/runtime.h>
QCLHeaderView *headerView;

@implementation UIScrollView (QCLRefresh)

- (void)setHeaderView:(QCLHeaderView *)headerView
{
    
    objc_setAssociatedObject(self, @"headerView", headerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (QCLHeaderView *)headerView {
    
    return objc_getAssociatedObject(self, @"headerView");
    
}

- (void)setFooterView:(QCLFooterView *)footerView {
    
    objc_setAssociatedObject(self, @"footerView", footerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (QCLFooterView *)footerView {
    
    
    return objc_getAssociatedObject(self, @"footerView");
}



- (void)setContentInsetTop:(CGFloat)contentInsetTop {
    
    UIEdgeInsets insets = self.contentInset;
    insets.top = contentInsetTop;
    
    self.contentInset = insets;
}

- (CGFloat)contentInsetTop {
    
    return self.contentInset.top;
}


- (void)setContentInsetBottom:(CGFloat)contentInsetBottom {
    
    UIEdgeInsets insets = self.contentInset;
    insets.bottom = contentInsetBottom;
    self.contentInset = insets;
    
}

- (CGFloat)contentInsetBottom {
    
    return self.contentInset.bottom;
    
}


- (QCLHeaderView *)addHeaderRefresh:(headerBeginRefresh)headerBeightRefresh {
    
    
    
    self.headerView = [QCLHeaderView headerViewRefresh:headerBeightRefresh];
    self.headerView.scrollView = self;
    
    return self.headerView;
    
}

- (QCLFooterView *)addFooterRefresh:(footerBeginRefresh)footerBeightRefresh {
    
    self.footerView = [QCLFooterView footerViewRefresh:footerBeightRefresh];
    
    self.footerView.scrollView = self;
    
    return self.footerView;
}

- (void)endRefresh {
    [self.headerView endRefresh];
    [self.footerView endRefresh];
}




@end
