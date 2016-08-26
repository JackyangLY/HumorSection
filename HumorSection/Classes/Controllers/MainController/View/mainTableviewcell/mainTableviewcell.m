//
//  mainTableviewcell.m
//  HumorSection
//
//  Created by 洋洋 on 16/8/10.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "mainTableviewcell.h"
#import "UIImageView+WebCache.h"
@interface mainTableviewcell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewUrl;
@property (weak, nonatomic) IBOutlet UILabel *lableTitle;


@end
@implementation mainTableviewcell
+(instancetype)cellWithTableView:(UITableView *)tableview
{
    NSString *strMainID =@"strMainID";
    mainTableviewcell  *Cell =[tableview dequeueReusableCellWithIdentifier:strMainID];
    
    if (!Cell)
    {
        Cell =[[[NSBundle mainBundle]loadNibNamed:@"mainTableviewcell" owner:nil options:nil]firstObject];
    }
    
    return Cell;

}
- (void)awakeFromNib
{
    [super awakeFromNib];
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    
}
-(void)setMainModel:(mainDataModel *)mainModel
{
    _mainModel = mainModel;
    NSURL *url =[NSURL URLWithString:mainModel.StrCover];
    [self.imageViewUrl sd_setImageWithURL:url];
    self.lableTitle.text = mainModel.StrTitle;
}
@end
