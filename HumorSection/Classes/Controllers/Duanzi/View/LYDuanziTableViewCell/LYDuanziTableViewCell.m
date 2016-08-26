//
//  LYDuanziTableViewCell.m
//  HumorSection
//
//  Created by 洋洋 on 16/7/21.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "LYDuanziTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface LYDuanziTableViewCell()
{
    /**用户照片*/
    __weak IBOutlet UIImageView *imageAvatar;
    /**用户名*/
    __weak IBOutlet UILabel *labelUserName;
    /**发表时间*/
    __weak IBOutlet UILabel *labelTime;
    /**发表内容*/
    __weak IBOutlet UILabel *labelTitle;
    

    /**点赞次数*/
    __weak IBOutlet UIButton *buttonLike;

    __weak IBOutlet UIButton *buttonDislike;
    
    __weak IBOutlet UIButton *buttonFbWuliao;

    __weak IBOutlet UIButton *buttonShare;
}

@end
@implementation LYDuanziTableViewCell
+(instancetype)LYDuanziTableViewCellWithTableview:(UITableView *)tableview
{
    NSString *LYDuanziCellStyle = @"LYDuanziStyle";
    LYDuanziTableViewCell *duanziCell =[tableview dequeueReusableCellWithIdentifier:LYDuanziCellStyle];
    
    
    if (!duanziCell)
    {
        duanziCell = [[[NSBundle mainBundle]loadNibNamed:@"LYDuanziTableViewCell" owner:nil options:nil]firstObject];
        duanziCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return duanziCell;
}
-(void)setDzdataModel:(DZDataModel *)dzdataModel
{
    _dzdataModel = dzdataModel;
    labelUserName.text = dzdataModel.strUserName;
    labelTitle.text = dzdataModel.strContent;
    labelTime.text = [NSString stringWithFormat:@"%@",dzdataModel.strcreatedAt];
    NSURL *url = [NSURL URLWithString:dzdataModel.strUrlAvatar];
    [imageAvatar sd_setImageWithURL:url];
    CGFloat layerRadius = imageAvatar.frame.size.width/2.0;
    imageAvatar.layer.cornerRadius = layerRadius;
    NSString *strLike = self.dzdataModel.incrsModel.StrLike;
    if (strLike)
    {
        
        id like = strLike;
        NSString *setlike = [NSString stringWithFormat:@"%@",like];
        [buttonLike setTitle:setlike forState:UIControlStateNormal];
    }
    NSString *strDisLike = self.dzdataModel.incrsModel.StrDislike;
    if (strDisLike)
    {
        
        id dislike = strDisLike;
        NSString *setDislike = [NSString stringWithFormat:@"%@",dislike];
        [buttonDislike setTitle:setDislike forState:UIControlStateNormal];
    }
    
    NSString *strFbWuliao = self.dzdataModel.incrsModel.StrFbWuliao;
    if (strFbWuliao)
    {
        
        id FbWuliao = strFbWuliao;
        NSString *setFbWuliao = [NSString stringWithFormat:@"%@",FbWuliao];
        [buttonFbWuliao setTitle:setFbWuliao forState:UIControlStateNormal];
       
    }
    NSString *strShare = self.dzdataModel.incrsModel.StrFbWuliao;
    if (strShare)
    {
        
        id Share = strShare;
        NSString *setShare = [NSString stringWithFormat:@"%@",Share];
        [buttonShare setTitle:setShare forState:UIControlStateNormal];
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
