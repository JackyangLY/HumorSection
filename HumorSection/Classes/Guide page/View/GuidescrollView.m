//
//  GuidescrollView.m
//  HumorSection
//
//  Created by 洋洋 on 16/7/13.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//
#import "AppDelegate.h"
#import "GuidescrollView.h"
@interface GuidescrollView ()
//引导页图片的数组
@property (nonatomic ,copy) NSArray *arrImageNames;
@property (nonatomic ,strong) UIButton *btnNext;
@end
@implementation GuidescrollView

-(NSArray *)arrImageNames
{
    if (!_arrImageNames)
    {
        NSInteger count = 5;
        NSMutableArray *arrMuName  = [NSMutableArray arrayWithCapacity:count];
        for (NSInteger index = 0; index <count; index++)
        {
            NSString *strName = [NSString stringWithFormat:@"xiaoming%ld",(long)index];
            [arrMuName addObject:strName];
        }
        _arrImageNames = [arrMuName copy];
    }
    return _arrImageNames;
}
/**纯代码创建*/
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame] )
    {
        [self loadBasicSetting];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self loadBasicSetting];
    }
    return self;
}
-(void)loadBasicSetting
{
    self.frame=CGRectMake(0, 0, LYSCREEN_WIDTH, LYSCREEN_WIDTH);
    NSInteger count = self.arrImageNames.count;
    CGFloat imagewidth =self.bounds.size.width;
    CGFloat imageheight =self.bounds.size.height;
    for (NSInteger index = 0; index < count; index ++)
    {
        UIImageView *imageview =[[UIImageView alloc]initWithImage:[UIImage imageNamed:self.arrImageNames[index]]];
        [self addSubview:imageview];
        [imageview setFrame:CGRectMake(index * imagewidth, 0, imagewidth, imageheight)];
        if (index == (count -1))
        {
            [self loadNextButton:imageview];
        }
    
    }
    self.contentSize = CGSizeMake(count *imagewidth, 0);
    /**水平方向的滚动条*/
    self.showsHorizontalScrollIndicator=NO;
    /**设置分页*/
    self.pagingEnabled =YES;
    /**是否有弹簧效果*/
    [self setBounces:YES];
}

- (void)loadNextButton:(UIImageView *)imageView
{
    UIButton *btnNext = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnNext setTitle:@"跳过>>" forState:UIControlStateNormal];
    [btnNext setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    btnNext.titleLabel.font = [UIFont italicSystemFontOfSize:20];
    [self addSubview:btnNext];
    self.btnNext = btnNext;
        CGFloat width = 100;
        CGFloat height = 36 ;
    CGFloat ScreenHeight = self.frame.size.height;
   CGFloat X = (imageView.frame.size.width)*0.67 + CGRectGetMinX(imageView.frame);
    //  CGFloat X = (ScreenWidth - width/2) + (imageView.frame.size.width);
    CGFloat Y = ScreenHeight*0.88;
    btnNext.frame = CGRectMake(X, Y, width, height);
    
    [btnNext.layer setCornerRadius:5.0];
    [btnNext.layer setBorderColor:[UIColor whiteColor].CGColor];
    [btnNext.layer setBorderWidth:1.0];
    [btnNext.layer setMasksToBounds:YES];
    
    [btnNext addTarget:self action:@selector(tapNextAction) forControlEvents:UIControlEventTouchUpInside];
}
#if 0
-(void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger count = self.arrImageNames.count;
    //CGFloat imagewidth =self.bounds.size.width;
    CGFloat imageheight = self.bounds.size.height;
    CGFloat imagewidth = imageheight;
    for (NSInteger index = 0; index < count; index ++)
    {
        UIImageView *imageview =[[UIImageView alloc]initWithImage:[UIImage imageNamed:self.arrImageNames[index]]];
        [self addSubview:imageview];
        if (index == (count -1))
        {
            [self loadNextButton:imageview];
        }
        [imageview setFrame:CGRectMake(index * imagewidth, 0, imagewidth, imageheight)];
    }
    self.contentSize = CGSizeMake(count *imagewidth, 0);
    
    
    CGFloat width = 100;
    CGFloat height = 36;
    [_btnNext mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.equalTo(self.mas_bottom);
         make.trailing.equalTo(self);
         make.width.mas_equalTo(width);
         make.height.mas_equalTo(height);
     }];

}
#endif
- (void)tapNextAction
{
    // 保存版本号
    // NSUserDefaults:单例, 用法类似NSDictionary 就是能把信息存储到Bundle中的一个plist文件中
    NSString *strVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [[NSUserDefaults standardUserDefaults] setObject:strVersion forKey:@"oldVersionKey"];
    [[NSUserDefaults standardUserDefaults] synchronize]; // 强制现在就写入plist
    
    //NSLog(@"%@", NSHomeDirectory());
    
    // 跳转
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate loadMainController];
}




@end
