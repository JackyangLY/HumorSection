//
//  LYGIFTableViewCell.m
//  HumorSection
//
//  Created by 洋洋 on 16/8/7.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "LYGIFTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+GIF.h"
@interface LYGIFTableViewCell ()
/**用户头像*/
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
/**用户名*/
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
/**内容图片*/
@property (weak, nonatomic) IBOutlet UIImageView *imgContentUrl;
/**标题*/
@property (weak, nonatomic) IBOutlet UILabel *LabelTitle;
/**热门*/
@property (weak, nonatomic) IBOutlet UIImageView *imageFire;
/**点赞*/
@property (weak, nonatomic) IBOutlet UIButton *btnStrLike;
/**评论者*/
@property (weak, nonatomic) IBOutlet UILabel *Labelauthor;
/**评论内容*/
@property (weak, nonatomic) IBOutlet UILabel *Labelmessage;

@end
@implementation LYGIFTableViewCell
+(instancetype)LYGIFTableViewCellWithTableView:(UITableView *)tableview
{
    NSString *LYGIFTableViewCellID = @"LYGIFTableViewCell";
    LYGIFTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:LYGIFTableViewCellID];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"LYGIFTableViewCell"owner:nil options:nil]firstObject ];
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
    /**标题*/
    self.LabelTitle.text = shfDataModel.StrTitle;
    /**内容*/
    //NSURL *ImgcontentUrl =[NSURL URLWithString:shfDataModel.StrMdeia_data.Strmobile_img_url];
     NSURL *ImgcontentUrl =[NSURL URLWithString:shfDataModel.strImgUrl];
    [self.imgContentUrl sd_setImageWithURL:ImgcontentUrl];
  
    /**热门*/
    if (shfDataModel.StrHot_comment.StrAutor)
    {
        self.imageFire.image =[UIImage imageNamed:@"热门 "];
        /**评论者*/
        self.Labelauthor.text = shfDataModel.StrHot_comment.StrAutor;
        /**评语*/
        self.Labelmessage.text = shfDataModel.StrHot_comment.StrMessage;
        /**点赞*/
        [self.btnStrLike setTitle:[NSString stringWithFormat:@"%@",shfDataModel.StrHot_comment.StrLike] forState:UIControlStateNormal];
    }
    else
    {
        self.Labelauthor.text = nil;
        self.Labelmessage.text = nil;
        [self.btnStrLike setTitle:nil forState:UIControlStateNormal];
        [self.btnStrLike setImage:nil forState:UIControlStateNormal];
    }
    
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
