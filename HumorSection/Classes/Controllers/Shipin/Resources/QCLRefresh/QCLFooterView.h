//
//  QCLFooterView.h
//  CLRefresh
//
//  Created by hezhijingwei on 16/7/15.
//  Copyright © 2016年  . All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^footerBeginRefresh)(UIView *view);



@interface QCLFooterView : UIView


@property (nonatomic ,copy) footerBeginRefresh footerRefresh;
@property (nonatomic ,strong) UIScrollView *scrollView;


- (void)endRefresh;

+ (instancetype)footerViewRefresh:(footerBeginRefresh)footerRefresh;

@end
