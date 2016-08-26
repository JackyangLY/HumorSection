//
//  QCLFooterView.m
//  CLRefresh
//
//  Created by hezhijingwei on 16/7/15.
//  Copyright © 2016年  . All rights reserved.
//

#import "QCLFooterView.h"
#import "UIScrollView+QCLRefresh.h"

#define FOOTERVIEWHEIGHT 60
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
typedef NS_ENUM(NSInteger, stateType)
{
    stateTypeNormal, //正常状态
    stateTypePull, //上拉状态
    stateTypePush, //下拉状态
    stateTypeIsRefresh //正在刷新
};

@interface QCLFooterView ()

@property (nonatomic, assign) stateType state;

@property (nonatomic ,strong) UIImageView *imageView ;

@property (nonatomic ,strong) UILabel *label;

@property (nonatomic ,strong) UIActivityIndicatorView *act;

@end

@implementation QCLFooterView

+ (instancetype)footerViewRefresh:(footerBeginRefresh)footerRefresh {
    
    QCLFooterView *footerView = [[QCLFooterView alloc] initWithFrame:CGRectZero];
    
    footerView.footerRefresh = footerRefresh;
    
    return footerView;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    
    
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}


- (void)createUI
{
    
    if (self.imageView == nil)
    {
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrowUp"]];
        [self addSubview:self.imageView];
        self.imageView.frame = CGRectMake((SCREENWIDTH - 244)/2.0, 16, 28, 28);
    }
    
    if (self.label == nil)
    {
        self.label = [[UILabel alloc] init];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.text = @"上拉加载更多";
        [self addSubview:self.label];
        
        self.label.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame)+16, 0, 200, FOOTERVIEWHEIGHT);
    }
    
}



- (void)setScrollView:(UIScrollView *)scrollView
{
    
    _scrollView = scrollView;
    
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    self.state = stateTypeNormal;
    self.frame = CGRectMake(0, self.scrollView.frame.size.height+1, SCREENWIDTH, FOOTERVIEWHEIGHT);
    [scrollView addSubview:self];
 
    
}
- (void)dealloc
{
    
    [self removeObserver:self forKeyPath:@"state"];
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        [self didChangeContentOffset];
    }

    
    if ([keyPath isEqualToString:@"state"]) {
        
        [self setupUI];
        
    }
    
}

- (void)setupUI {

    switch (self.state) {
        case stateTypeNormal:
        {
         [self createUI];
        }
            break;
        case stateTypePull:
        {
            self.imageView.image = [UIImage imageNamed:@"arrowUp"];
            self.label.text = @"上拉加载更多";
        }
            break;
        case stateTypePush:
        {
            self.imageView.image = [UIImage imageNamed:@"arrowDown"];
            self.label.text = @"松开即可加载更多";
            
            self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, FOOTERVIEWHEIGHT, 0);
        }
            break;
        case stateTypeIsRefresh:
        {
            [self.imageView setHidden:YES];
            self.label.text = @"正在加载，请稍后。。。";
            
            if (!self.act) {
                
                self.act = [[UIActivityIndicatorView alloc] initWithFrame:self.imageView.frame];
                self.act.center = self.imageView.center;
                [self addSubview:self.act];
                self.act.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
                [self.act startAnimating];
                
                if (_footerRefresh) {
                    _footerRefresh(self);
                }
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)didChangeContentOffset {
    
    CGFloat contentSizeHeight = self.scrollView.contentSize.height;
    CGFloat contentOffsetY = self.scrollView.contentOffset.y;
    CGFloat scrollView_height = self.scrollView.frame.size.height;
    self.frame = CGRectMake(0, contentSizeHeight+1, SCREENWIDTH, FOOTERVIEWHEIGHT);
    if (self.scrollView.isDragging) {
        
        if (contentSizeHeight < contentOffsetY + scrollView_height) {

            if (scrollView_height + contentOffsetY - contentSizeHeight > FOOTERVIEWHEIGHT) {
                self.state = stateTypePush;
            } else {
                
                self.state = stateTypePull;
                
            }
        }
        
    } else {

        if (self.state == stateTypePush) {
            self.state = stateTypeIsRefresh;
        }
        
 
    }
    
}
- (void)endRefresh
{
    self.label.text = @"刷新成功";
    
    [self.act removeFromSuperview];
    self.act = nil;
    
    self.imageView.image = [UIImage imageNamed:@"对号"];
    self.imageView.hidden = NO;
    [self performSelector:@selector(endRefreshNow) withObject:nil afterDelay:0.3];
}

- (void)endRefreshNow {
    
    [UIView animateWithDuration:0.3 animations:^{
       
         self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    } completion:^(BOOL finished) {
        [self.imageView removeFromSuperview];
        [self.label removeFromSuperview];
        self.label = nil;
        self.imageView = nil;
        self.state = stateTypeNormal;

    }];
    
}



@end
