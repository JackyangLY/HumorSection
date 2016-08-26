//
//  DataModel.h
//  json解析
//
//  Created by 洋洋 on 16/8/4.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHFHotCommentModel.h"
#import "SHFMediaDataModel.h"
@interface SHFDataModel : NSObject

@property(nonatomic,strong) NSMutableArray *arrMuData;
 /**user_name 用户名*/
@property(nonatomic,strong) NSString *StrUser_name;
 /**dislike_start */
@property(nonatomic,assign) NSInteger StrdDislike_start;
 /**_created_at 发表时间*/
@property(nonatomic,strong) NSString *StrCreated_at;
 /**avatar 用户头像*/
@property(nonatomic,strong) NSString *StrAvatar;
 /**title 标题*/
@property(nonatomic,strong) NSString *StrTitle;
 /**hot_comment*/

@property(nonatomic,strong) SHFHotCommentModel *StrHot_comment;
 /**_updated_at 更新时间*/
@property(nonatomic,strong) NSString *StrUpdated_at;
 /**_incrs*/
//@property(nonatomic,strong) NSString *StrIncrs;
 /**_pos*/
@property(nonatomic,assign) NSInteger StrPos;
 /**comment_total*/
@property(nonatomic,assign) NSInteger StrComment_total;
 /**tag 属性*/
@property(nonatomic,strong) NSString *StrTag;
 /**_id ID*/
@property(nonatomic,strong) NSString *StrId;
 /**like_start*/
@property(nonatomic,assign) NSInteger Strlike_start;

@property(nonatomic,strong) NSString *strImgUrl;
/**content  发表内容*/
@property(nonatomic,strong) NSString *StrContent;

@property(nonatomic,strong) SHFMediaDataModel *StrMdeia_data;
+(instancetype)SHFDataModelWithDictionary:(NSDictionary *)dict;

@end
