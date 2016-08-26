//
//  QCLHeaderView.m
//  CLRefresh
//
//  Created by hezhijingwei on 16/7/15.
//  Copyright © 2016年  . All rights reserved.
//

#import "QCLHeaderView.h"

#define HEADERVIEWHEIGHT 60
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#import "UIScrollView+QCLRefresh.h"

typedef NS_ENUM(NSInteger, stateType)
{
    
    stateTypeNormal,
    stateTypePull,
    stateTypePush,
    stateTypeIsRefreshing
    
};



@interface QCLHeaderView ()<UIScrollViewDelegate> {
    
    UIScrollView *_scrollView;
    
}

@property (nonatomic, assign) stateType state;


@property (nonatomic, assign) CGFloat currentContentOffset;

@property (nonatomic ,strong) UIActivityIndicatorView *act;

@property (nonatomic ,strong) UIImageView *imageView;

@property (nonatomic ,strong) UILabel *label;

@property (nonatomic, assign) BOOL isuping;;



@end

@implementation QCLHeaderView
/**重写headerBeginRefresh*/

+ (instancetype)headerViewRefresh:(headerBeginRefresh)headerRefresh {
    
    QCLHeaderView *view = [[QCLHeaderView alloc] initWithFrame:CGRectZero];
    
    view.headerRefresh = headerRefresh;
    return view;
    
}

- (void)beginHeaderRefresh
{
    
    [UIView animateWithDuration:0.5 animations:^{
       
        self.scrollView.contentOffset = CGPointMake(0, - HEADERVIEWHEIGHT - 10);
        
    }];
    
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, -HEADERVIEWHEIGHT, SCREENWIDTH, HEADERVIEWHEIGHT)];
    if (self)
    {
        self.state = stateTypeNormal;
        [self createTimeLabel];
        self.currentContentOffset = -100000;
        [self addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)didChangeScrollViewContentOffset
{
      if (self.scrollView.isDragging)
    {
        
        if (self.scrollView.contentOffset.y > -HEADERVIEWHEIGHT)
        {
            
            self.state = stateTypePull; //拉伸高度小于60

        } else
        {

            self.state = stateTypePush; //表示拉过60
            
            
        }
        
    } else {
        
        if (self.scrollView.contentOffset.y < -60)
        {
            
            self.state = stateTypeIsRefreshing;
        }
        
    }
    
}


- (void)endRefresh {
    
    self.label.text = @"刷新成功";
    
    [self.act removeFromSuperview];
    self.act = nil;
    
    self.imageView.image = [UIImage imageNamed:@"对号"];
    self.imageView.hidden = NO;
    
    [self performSelector:@selector(endRefreshNow) withObject:nil afterDelay:0.4];
    
}


- (void)endRefreshNow
{
    
    [UIView animateWithDuration:0.3 animations:^
    {
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    } completion:^(BOOL finished) {
        
        self.state = stateTypeNormal;

    }];
    
}

- (void)dealloc {
    
    [self removeObserver:self forKeyPath:@"state"];
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}


- (void)setScrollView:(UIScrollView *)scrollView {
    
    
    if (_scrollView != scrollView) {
        
        _scrollView = scrollView;

        [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        
        [scrollView addSubview:self];
    }
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"contentOffset"])
    {
        [self didChangeScrollViewContentOffset];
    }
    
    if ([keyPath isEqualToString:@"state"])
    {
        [self setupUI];
    }
}

- (void)setupUI {
    
    switch (self.state)
    {
        case stateTypeNormal:
        {
            [self.act removeFromSuperview];
            self.act = nil;
            self.imageView.hidden = NO;
        }
            break;
        case stateTypePull:
        {

            self.imageView.image = [UIImage imageNamed:@"arrowDown"];
            self.label.text = @"下拉刷新";
        }
            break;
        case stateTypePush:
        {
            self.imageView.image = [UIImage imageNamed:@"arrowUp"];
            self.label.text = @"释放即可刷新";
            self.scrollView.contentInset = UIEdgeInsetsMake(HEADERVIEWHEIGHT, 0, 0, 0);
         }
            break;
        case stateTypeIsRefreshing:
        {
            self.imageView.hidden = YES;
            
            if (!self.act) {
                
                self.act = [[UIActivityIndicatorView alloc] initWithFrame:self.imageView.frame];
                self.act.center = self.imageView.center;
                [self addSubview:self.act];
                self.act.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
                [self.act startAnimating];
                
                if (_headerRefresh) {
                    _headerRefresh(self);
                }
             }
        }
            break;
            
            
        default:
            break;
    }
    
}


- (void)createTimeLabel
{
     self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrowDown"]];
     [self addSubview:self.imageView];
    
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"下拉刷新";
    [self addSubview:label];
    self.label = label;

       
    self.imageView.frame = CGRectMake((SCREENWIDTH - 244)/2.0, 16, 28, 28);
        label.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame)+16, 0, 200, HEADERVIEWHEIGHT);
    
}




@end
