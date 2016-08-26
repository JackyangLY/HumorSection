//
//  ButtonSetscrollView.h
//  ShowSmile
//
//  Created by 洋洋 on 16/7/6.
//  Copyright © 2016年 Jack_yangyang. All rights reserved.
//按钮滑动视图

#import <UIKit/UIKit.h>
#import "ButtonNameModels.h"
@interface ButtonSetscrollView : UIScrollView
@property (nonatomic ,strong)ButtonNameModels *buttonModels;
@property (nonatomic , copy) void (^blockClickChangeAction)(UIButton *button);
@end
