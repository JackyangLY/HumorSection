//
//  LYSHFTableViewCell.m
//  HumorSection
//
//  Created by 洋洋 on 16/8/6.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "LYMCJZYTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface LYMCJZYTableViewCell ()
 /**用户头像*/
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
/**用户名*/
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
/**标题*/
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
/**内容图片*/
@property (weak, nonatomic) IBOutlet UIImageView *imgContentUrl;



@end
@implementation LYMCJZYTableViewCell
+(instancetype)LYMCJZYTableViewCellWithTableView:(UITableView *)tableview
{
    NSString *LYSHFTableViewCellID = @"LYMCJZYTableViewCell";
    LYMCJZYTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:LYSHFTableViewCellID];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"LYMCJZYTableViewCell"owner:nil options:nil]firstObject ];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor lightGrayColor];
    }
    return cell;
}
-(void)setShfDataModel:(SHFDataModel *)shfDataModel
{
    _shfDataModel = shfDataModel;
    /**用户头像*/
    NSURL *urlAvatat =[NSURL URLWithString:shfDataModel.StrAvatar];
    CGFloat layerRadius = _imgAvatar.frame.size.width/2.0;
    _imgAvatar.layer.cornerRadius = layerRadius;
    [_imgAvatar sd_setImageWithURL:urlAvatat];
    /**用户名*/
    self.lblUserName.text = shfDataModel.StrUser_name;
    self.lblTitle.text = shfDataModel.StrTitle;
    /**内容*/
    NSURL *urlMdeia  =[NSURL URLWithString:shfDataModel.StrMdeia_data.StrWif_img_url];
    [self.imgContentUrl sd_setImageWithURL:urlMdeia];

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
