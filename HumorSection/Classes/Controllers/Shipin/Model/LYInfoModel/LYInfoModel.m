//
//  LYInfoModel.m
//  HumorSection
//
//  Created by 洋洋 on 16/8/3.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "LYInfoModel.h"
@implementation LYInfoModel
+(instancetype)LYInfoModelWithDict:(NSDictionary *)dict
{
    return [[LYInfoModel alloc]initWithDictionary:dict];
    
}
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self =[super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    if ([key isEqualToString:@"_created_at"])
    {
        [self setValue:value forKey:@"StrCreated_at"];
    }
        if ([key isEqualToString:@"_id"])
    {
        [self setValue:value forKey:@"StrId"];
    }
    if ([key isEqualToString:@"_pos"])
    {
        [self setValue:value forKey:@"Strpos"];
    }
    if ([key isEqualToString:@"_updated_at"])
    {
        [self setValue:value forKey:@"StrUpdated_at"];
    }
    if ([key isEqualToString:@"antispam_filter"])
    {
        [self setValue:value forKey:@"StrAntispam_filter"];
    }
    if ([key isEqualToString:@"antispam_id"])
    {
        [self setValue:value forKey:@"StrAntispam_id"];
    }
    if ([key isEqualToString:@"_antispam_md5;"])
    {
        [self setValue:value forKey:@"StrAntispam_md5;"];
    }
    if ([key isEqualToString:@"antispam_mode"])
    {
        [self setValue:value forKey:@"StrAntispam_mode"];
    }
    if ([key isEqualToString:@"antispam_result"])
    {
        [self setValue:value forKey:@"StrAntispam_result"];
    }
    if ([key isEqualToString:@"antispam_time"])
    {
        [self setValue:value forKey:@"StrAntispam_time"];
    }
    if ([key isEqualToString:@"avatar"])
    {
        [self setValue:value forKey:@"StrAvatar"];
    }
    if ([key isEqualToString:@"comment_total"])
    {
        [self setValue:value forKey:@"StrComment_total"];
    }
    if ([key isEqualToString:@"content"])
    {
        [self setValue:value forKey:@"StrContent"];
    }

    if ([key isEqualToString:@"_disliske_start"])
    {
        [self setValue:value forKey:@"StrDisliske_start"];
    }
    if ([key isEqualToString:@"forum"])
    {
        [self setValue:value forKey:@"StrForum"];
    }
    if ([key isEqualToString:@"like_start"])
    {
        [self setValue:value forKey:@"StrLike_start"];
    }
    if ([key isEqualToString:@"post_time"])
    {
        [self setValue:value forKey:@"StrPost_time"];
    }
    if ([key isEqualToString:@"qiqu_index_url"])
    {
        [self setValue:value forKey:@"StrQiqu_index_url"];
    }
    if ([key isEqualToString:@"share_start"])
    {
        [self setValue:value forKey:@"StrShare_start"];
    }
    if ([key isEqualToString:@"tag"])
    {
        [self setValue:value forKey:@"StrTag"];
    }
    if ([key isEqualToString:@"url"])
    {
        [self setValue:value forKey:@"StrUrl"];
    }
    if ([key isEqualToString:@"user_name"])
    {
        [self setValue:value forKey:@"strUser_name"];
    }

}
@end
