//
//  QCLHeaderView.h
//  CLRefresh
//
//  Created by hezhijingwei on 16/7/15.
//  Copyright © 2016年  . All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  定义一个headerBeginRefresh并加一个参数view
 */
typedef void(^headerBeginRefresh)(UIView *view);

@interface QCLHeaderView : UIView

@property (nonatomic ,strong) UIScrollView *scrollView;

@property (nonatomic ,copy) headerBeginRefresh headerRefresh;

+ (instancetype)headerViewRefresh:(headerBeginRefresh)headerRefresh;

//- (void)beginHeaderRefresh;
- (void)endRefresh;

@end
