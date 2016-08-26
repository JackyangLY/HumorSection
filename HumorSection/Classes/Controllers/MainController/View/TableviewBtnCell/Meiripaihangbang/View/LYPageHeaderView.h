//
//  LKQPageHeaderView.h
//  SScroll
//
//  Created by  on 16/7/15.
//  Copyright © 2016年  All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol pageHeaderBtnDelegate <NSObject>

-(void)pageCurrentBtn:(NSInteger)current;

@end

@interface LYPageHeaderView : UIView<UIScrollViewDelegate>

@property(nonatomic,weak,nullable)id  <pageHeaderBtnDelegate> delegate;

@property(nullable,nonatomic,strong)UIScrollView *scrollview;
@property(nullable, nonatomic,copy) NSArray<__kindof UIButton *> *buttons;

@property(nullable,nonatomic,strong)UIButton *currentBtn;

- (nullable instancetype)initWithFrame:(CGRect)frame names:(NSArray<__kindof NSString *> * __nullable)names;

- (void)setCurrentheaderbtn:(NSInteger)index;
@end
