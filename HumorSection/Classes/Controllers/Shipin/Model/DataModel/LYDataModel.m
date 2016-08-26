//
//  LYDataModel.m
//  HumorSection
//
//  Created by 洋洋 on 16/8/3.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "LYDataModel.h"

@implementation LYDataModel
+(instancetype)LYDataModelWithDict:(NSDictionary *)dict
{
    return [[LYDataModel alloc]initLYDataModelWithDict:dict];
}
-(instancetype)initLYDataModelWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

    /**user_name 用户名*/
    if ([key isEqualToString:@"user_name"])
    {
        [self setValue:value forKey:@"StrUser_name"];
    }
        /**dislike_start */
    if ([key isEqualToString:@"dislike_start"])
    {
        [self setValue:value forKey:@"StrDislike_start"];
    }
    /**_created_at 创建时间*/
    if ([key isEqualToString:@"_created_at"])
    {
        [self setValue:value forKey:@"StrCreated_at"];
    }

    /**list_info */
    if ([key isEqualToString:@"list_info"])
    {
        [self setValue:value forKey:@"ArrLsit_info"];
    }

    /**avatar 用户头像*/
    if ([key isEqualToString:@"avatar"])
    {
        [self setValue:value forKey:@"StrAvatar"];
    }
        /**title 标题*/
    if ([key isEqualToString:@"title"])
    {
        [self setValue:value forKey:@"StrTitle"];
    }

    /**content 发表内容*/
    if ([key isEqualToString:@"content"])
    {
        [self setValue:value forKey:@"StrContent"];
    }

    /**hot_comment */
    if ([key isEqualToString:@"hot_comment"])
    {
        [self setValue:value forKey:@"DcitHot_comment"];
    }

    /**_updated_at 更新时间*/
    if ([key isEqualToString:@"_updated_at"])
    {
        [self setValue:value forKey:@"StrUpdated_at"];
    }
    /**_incrs */
    if ([key isEqualToString:@"_incrs"])
    {
        NSDictionary *DictIncrs = value;
        
        [self setValue:DictIncrs forKey:@"DictIncrs"];
    }
        /**_pos */
    if ([key isEqualToString:@"_pos"])
    {
        [self setValue:value forKey:@"StrPos"];
    }
    /**comment_total */
    if ([key isEqualToString:@"comment_total"])
    {
        [self setValue:value forKey:@"StrComment_total"];
    }
    /**tag  类型*/
    if ([key isEqualToString:@"tag"])
    {
        [self setValue:value forKey:@"StrTag"];
    }
        /**_id */
    if ([key isEqualToString:@"_id"])
    {
        [self setValue:value forKey:@"StrId"];
    }
        /**like_start */
    if ([key isEqualToString:@"like_start"])
    {
        [self setValue:value forKey:@"StrLike_start"];
    }
    
    if ([key isEqualToString:@"media_data"])
    {
        NSArray *arrData = value;
        for (NSDictionary *dict in arrData)
        {
            NSDictionary *DictMediaData  = dict;
            [self setValue:DictMediaData forKey:@"DictMediaData"];
        }

        
    }
}
@end
