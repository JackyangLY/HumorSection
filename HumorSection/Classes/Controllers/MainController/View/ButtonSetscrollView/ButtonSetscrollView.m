//
//  ButtonSetscrollView.m
//  ShowSmile
//
//  Created by 洋洋 on 16/7/6.
//  Copyright © 2016年 Jack_yangyang. All rights reserved.
//按钮滑动视图

#import "ButtonSetscrollView.h"
@interface ButtonSetscrollView ()

/**存放btn的image的模型的数组*/
@property (nonatomic ,copy) NSArray *arrButtonImageNames;


@property (nonatomic ,assign) NSInteger clickIndex;

@end
@implementation ButtonSetscrollView
/** 懒加载数组模型数据 */
- (NSArray *)arrButtonImageNames
{
    if (_arrButtonImageNames == nil)
    {
        // 获取资源路径
        NSString *strPath = [[NSBundle mainBundle] pathForResource:@"xiaohuangrenImageName" ofType:@"plist"];
        // 从资源路径加载数组
        NSArray *arrNames = [NSArray arrayWithContentsOfFile:strPath];
        // 创建一个临时的可变数组
        NSMutableArray *arrMNameModels = [NSMutableArray arrayWithCapacity:arrNames.count];
        // 循环遍历创建模型, 并添加到可变数组中
        for (NSDictionary *dicData in arrNames)
        {
            ButtonNameModels *model = [ButtonNameModels modelWithDicitionary:dicData];
            [arrMNameModels addObject:model];
        }
        // 最终赋值
        _arrButtonImageNames = [arrMNameModels copy];
    }
    return _arrButtonImageNames;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self loadBasicSetting];
    }
    return self;
}
-(void)layoutSubviews
{
     [super layoutSubviews];
   // [self  setBackgroundColor:[UIColor whiteColor]];
       /**隐藏水平滑动指示器*/
    self.showsHorizontalScrollIndicator = NO ;
}
-(void)loadBasicSetting
{
    NSInteger count =self.arrButtonImageNames.count;
    CGFloat  imageButtonWidthHeight = LYSCREEN_WIDTH * 0.096;
    NSInteger buttonGapY = 10;
    NSInteger buttonGapX = LYSCREEN_WIDTH * 0.12;
    for (NSInteger index =0; index < count; index ++)
    {
        UIButton *button =[UIButton new];
        button.tag = index+1;
        NSInteger buttonX = index*(buttonGapX + imageButtonWidthHeight)+buttonGapX;
        ButtonNameModels *model= self.arrButtonImageNames[index];
        NSString *strName = model.strTconHeight;
        [button setBackgroundImage:[UIImage imageNamed:strName] forState:
         UIControlStateNormal];
        NSString *strNameheight = model.strIcon;
        [button setBackgroundImage:[UIImage imageNamed:strNameheight] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(clickButtonChangeViewController:) forControlEvents:UIControlEventTouchUpInside];
        button.frame =CGRectMake(buttonX, buttonGapY, imageButtonWidthHeight, imageButtonWidthHeight);
        [self addSubview:button];
        
        /**button下面添加label*/
        UILabel *buttonNameLabel = [UILabel new];
        NSString *strText = model.strName;
        [buttonNameLabel setText:[NSString stringWithFormat:@"%@",strText]];
        [buttonNameLabel setTextAlignment:NSTextAlignmentCenter];
         [buttonNameLabel setFrame:CGRectMake(buttonX , buttonGapY*1.2 + imageButtonWidthHeight, imageButtonWidthHeight , imageButtonWidthHeight / 2)];
        [self addSubview:buttonNameLabel];

    }
    self.contentSize=CGSizeMake(count * (imageButtonWidthHeight + buttonGapY *4 ), 1);
}
-(void)clickButtonChangeViewController :(UIButton *)button;
{
    // 把所有的UIButton置为未选中
    for (UIButton *btn in self.subviews)
    {
        if ([btn isKindOfClass:[UIButton class]])
        {
            btn.enabled = YES;
        }
    }
    // 选中用户选中的按钮, 如果contentSize的大小有一个为0, 这个方法就不起作用
    button.enabled = NO;
    
    // 让指定的区域可见
    [self scrollRectToVisible:button.frame animated:YES];
    

  //  NSLog(@"%ld --%@",button.tag,button.titleLabel);
    if (self.blockClickChangeAction)
    {
        self.blockClickChangeAction(button);
    }
}

@end
