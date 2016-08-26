//
//  LYDataModel.h
//  HumorSection
//
//  Created by 洋洋 on 16/8/3.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYDataModel : NSObject

/**user_name 用户名*/
@property(nonatomic ,copy) NSString *StrUser_name;
/**dislike_start */
@property(nonatomic,assign) NSInteger StrDislike_start;
/**_created_at 创建时间*/
@property(nonatomic,copy) NSString *StrCreated_at;
/**list_info */
@property(nonatomic,copy) NSArray *ArrLsit_info;
/**avatar 用户头像*/
@property(nonatomic,copy) NSString *StrAvatar;
/**title 标题*/
@property(nonatomic,copy) NSString *StrTitle;
/**content 发表内容*/
@property(nonatomic,copy) NSString *StrContent;
/**hot_comment */
@property(nonatomic,copy) NSDictionary *DcitHot_comment;
/**_updated_at 更新时间*/
@property(nonatomic,copy) NSString *StrUpdated_at;
/**_incrs */
@property(nonatomic,copy) NSDictionary *DictIncrs;
/**_pos */
@property(nonatomic,copy) NSString *StrPos;
/**comment_total */
@property(nonatomic,assign) NSInteger StrComment_total;
/**tag  类型*/
@property(nonatomic,copy) NSString *StrTag;
/**_id */
@property(nonatomic ,copy) NSString *StrId;
/**like_start */
@property(nonatomic,assign) NSInteger StrLike_start;
/**media_data*/
@property(nonatomic,copy) NSDictionary *DictMediaData;

+(instancetype)LYDataModelWithDict:(NSDictionary *)dict;
@end
