//
//  ShipinCollectionViewCell.m
//  HumorSection
//
//  Created by 洋洋 on 16/7/13.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "ShipinCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "AVFoundation/AVFoundation.h"
#import "AVKit/AVKit.h"

#define  BaseUrl @"http://qiqu.uc.cn/api/video?id="
@interface ShipinCollectionViewCell ()
/**用户头像*/
@property (weak, nonatomic) IBOutlet UIImageView *imgUserNameView;
/**用户名*/
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
/**内容标题*/
@property (weak, nonatomic) IBOutlet UILabel *lblContentTitle;
/**内容视图*/
@property (weak, nonatomic) IBOutlet UIImageView *imgContentView;
/** */
@property (weak, nonatomic) IBOutlet UIButton *lblLike;
/** */
@property (weak, nonatomic) IBOutlet UIButton *lblDislike;
/** */
@property (weak, nonatomic) IBOutlet UIButton *lblWuliao;
/** */
@property (weak, nonatomic) IBOutlet UIButton *lblShare;


@end
@implementation ShipinCollectionViewCell
+(instancetype)cellWithTableView:(UITableView *)tableview
{

    NSString *strNcellID =@"strNcellID";
    ShipinCollectionViewCell  *Cell =[tableview dequeueReusableCellWithIdentifier:strNcellID];
    
    if (!Cell)
    {
        Cell =[[[NSBundle mainBundle]loadNibNamed:@"ShipinCollectionViewCell" owner:nil options:nil]firstObject];
    }
    
    return Cell;
}

/**纯代码创建时加载*/
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]  )
    {
       
    }
    return self;
}
/**创建Xib时加载*/
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
//        self.imageview.layer.cornerRadius = 25;
//        self.imageview.layer.masksToBounds = YES;
        
    }
    return self;
}

-(void)setLyDataModel:(LYDataModel *)lyDataModel
{
    _lyDataModel = lyDataModel;
    NSURL *UserNameurl = [NSURL URLWithString:lyDataModel.StrAvatar];
    [self.imgUserNameView sd_setImageWithURL:UserNameurl];

    CGFloat layerRadius = _imgUserNameView.frame.size.width/2.0;
    self.imgUserNameView.layer.cornerRadius = layerRadius;

      self.lblUserName.text = _lyDataModel.StrUser_name;
    self.lblContentTitle.text = _lyDataModel.StrTitle;
    NSDictionary *dictMediaData = lyDataModel.DictMediaData[@"origin_img_url"];
    NSString *StrOriginUrl = dictMediaData[@"origin_pic_url"];
    
    NSURL *contentUrl = [NSURL URLWithString:StrOriginUrl];
    [self.imgContentView sd_setImageWithURL:contentUrl];
    
    NSString *strLike = lyDataModel.DictIncrs[@"like"];
    if (strLike)
    {
        
        id like = strLike ;
        
        NSString *setLike = [NSString stringWithFormat:@"%@",like];
        [_lblLike setTitle:setLike forState:UIControlStateNormal];
    }
    NSString *strDisLike = lyDataModel.DictIncrs[@"dislike"];
    if (strDisLike)
    {
        
        id Dislike = strDisLike ;
        NSString *setDisLike = [NSString stringWithFormat:@"%@",Dislike];
        [_lblDislike setTitle:setDisLike forState:UIControlStateNormal];
    }
    
    NSString *strWuliao = lyDataModel.DictIncrs[@"fb_wuliao"];
    if (strWuliao)
    {
        
        id Wuliao = strWuliao;
        NSString *setWuliao= [NSString stringWithFormat:@"%@",Wuliao];
        [_lblWuliao setTitle:setWuliao forState:UIControlStateNormal];
    }
    NSString *strShare = lyDataModel.DictIncrs[@"share"];
    if (strShare)
    {
        
        id Share = strShare ;
        NSString *setShare = [NSString stringWithFormat:@"%@",Share];
        [_lblShare setTitle:setShare forState:UIControlStateNormal];
        
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
   
}


@end
