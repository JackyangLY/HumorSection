//
//  LYInfoModel.h
//  HumorSection
//
//  Created by 洋洋 on 16/8/3.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYInfoModel : NSObject

@property(nonatomic, copy) NSString *StrCreated_at;
@property(nonatomic, assign) NSInteger StrId;
@property(nonatomic, assign) NSInteger Strpos;
@property(nonatomic, copy) NSString *StrUpdated_at;
@property(nonatomic, copy) NSString *StrAntispam_filter;
@property(nonatomic, copy) NSString *StrAntispam_id;
@property(nonatomic, copy) NSString *StrAntispam_md5;
@property(nonatomic, copy) NSString *StrAntispam_mode;
@property(nonatomic, copy) NSString *StrAntispam_result;
@property(nonatomic, copy) NSString *StrAntispam_time;
@property(nonatomic, copy) NSString *StrAvatar ;
@property(nonatomic, copy) NSString *StrComment_total;
@property(nonatomic, copy) NSString *StrContent;
@property(nonatomic, copy) NSString *StrDisliske_start;
@property(nonatomic, copy) NSString *StrForum;
@property(nonatomic, copy) NSString *StrLike_start;
@property(nonatomic,copy) NSString *StrPost_time;
@property(nonatomic,copy) NSString *StrQiqu_index_url;
@property(nonatomic,assign) NSInteger StrShare_start;
@property(nonatomic,copy) NSString *StrTag;
@property(nonatomic,copy) NSString *StrUrl;
@property(nonatomic,copy) NSString *strUser_name;
+(instancetype)LYInfoModelWithDict:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;
@end
