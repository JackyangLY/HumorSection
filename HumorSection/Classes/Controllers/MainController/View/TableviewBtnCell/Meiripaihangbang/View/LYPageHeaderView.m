//
//  LYPageHeaderView.m
//  SScroll
//
//  Created by on 16/7/15.
//  Copyright © 2016年  All rights reserved.
//

#import "LYPageHeaderView.h"

@implementation LYPageHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame names:(NSArray<__kindof NSString *> *)names
{
    if (self=[super initWithFrame:frame]) {
/**开启交互*/
        self.userInteractionEnabled=YES;
        
        self.scrollview=[[UIScrollView alloc]initWithFrame:self.bounds];
//        self.scrollview.delegate=self;
//        self.scrollview.pagingEnabled=YES;
        [self addSubview:self.scrollview];
        
        self.scrollview.showsHorizontalScrollIndicator=NO;

        
        NSMutableArray *btns=[[NSMutableArray alloc]init];
        
        CGFloat lastX=0;
        for (NSInteger i=0; i<names.count; i++) {
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:names[i] forState:UIControlStateNormal];
            
            NSString *string=names[i];
            CGRect rect=[string boundingRectWithSize:CGSizeMake(1000, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:[UIFont systemFontSize]]} context:nil];
            
            button.frame=CGRectMake(lastX+10, 0, rect.size.width+20, 30);
            lastX+=10+rect.size.width+20;
            
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(headerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollview addSubview:button];
            
            [btns addObject:button];
            
            if (i==0) {
                button.selected=YES;
                self.currentBtn=button;
            }
            
        }
          self.buttons=btns;
        UIButton *lastBtn=[self.buttons lastObject];
        self.scrollview.contentSize=CGSizeMake(CGRectGetMaxX(lastBtn.frame), 0);
           
    }
    return self;
}


-(void)headerBtnClick:(UIButton *)headerBtn
{
    NSInteger currentPage=[self.buttons indexOfObjectIdenticalTo:headerBtn];
    [self setCurrentheaderbtn:currentPage];
    if (self.delegate) {
        [self.delegate pageCurrentBtn:currentPage];
    }
    
}

-(void)setCurrentheaderbtn:(NSInteger)index
{
    self.currentBtn.selected=NO;
    self.currentBtn=self.buttons[index];
    self.currentBtn.selected=YES;
}

@end
