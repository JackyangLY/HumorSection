//
//  LYSHFTEXTTableViewCell.m
//  HumorSection
//
//  Created by 洋洋 on 16/8/8.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "LYSHFTEXTTableViewCell.h"

#import "UIImageView+WebCache.h"


@interface LYSHFTEXTTableViewCell ()
/**用户头像*/
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
/**用户名*/
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
/**内容图片*/
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@property (weak, nonatomic) IBOutlet UIImageView *imageFire;
/**点赞*/
@property (weak, nonatomic) IBOutlet UIButton *btnStrLike;
/**评论者*/
@property (weak, nonatomic) IBOutlet UILabel *Labelauthor;
/**评论内容*/
@property (weak, nonatomic) IBOutlet UILabel *Labelmessage;

@end
@implementation LYSHFTEXTTableViewCell
+(instancetype)LYSHFTEXTTableViewCellWithTableView:(UITableView *)tableview
{
    NSString *LYSHFTableViewCellID = @"LYSHFTEXTTableViewCell";
    LYSHFTEXTTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:LYSHFTableViewCellID];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"LYSHFTEXTTableViewCell"owner:self options:nil]firstObject ];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor lightGrayColor];
    }
    return cell;
}
-(void)setShfDataModel:(SHFDataModel *)shfDataModel
{
    shfDataModel = shfDataModel;
    /**用户头像*/
    NSURL *urlAvatat =[NSURL URLWithString:shfDataModel.StrAvatar];
    CGFloat floatRadius = _imgAvatar.frame.size.height/2.0;
    _imgAvatar.layer.cornerRadius = floatRadius;
    [_imgAvatar sd_setImageWithURL:urlAvatat];
    /**用户名*/
    self.lblUserName.text = shfDataModel.StrUser_name;
    /**内容*/
    self.lblContent.text = shfDataModel.StrContent;
    /**热门*/
    if (shfDataModel.StrHot_comment.StrMessage)
    {
        self.imageFire.image =[UIImage imageNamed:@"热门 "];
        /**评论者*/
        if (shfDataModel.StrHot_comment.StrAutor)
        {
            self.Labelauthor.text = shfDataModel.StrHot_comment.StrAutor;
            if ([self.Labelauthor.text isEqualToString:@""])
            {
                self.Labelauthor.text = @"热评";
                
            }
        }
        else
        {
            self.Labelauthor.text = @"热评";

        }
       
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
