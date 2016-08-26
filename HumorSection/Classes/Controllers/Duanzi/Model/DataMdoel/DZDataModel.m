//
//  DataModel.m
//  New——
//
//  Created by 洋洋 on 16/7/27.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "DZDataModel.h"
@implementation DZDataModel
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return  self;
    
}
+(instancetype)DatamodelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"user_name"])
    {
        NSString *strUserName = value;
        [self setValue:strUserName forKey:@"strUserName"];
    }
    if ([key isEqualToString:@"avatar"])
    {
        NSString *strUrlAvatar = value;
        [self setValue:strUrlAvatar forKey:@"strUrlAvatar"];
    }
    if ([key isEqualToString:@"title"]) {
        NSString *strTitle= value;
        [self setValue:strTitle forKey:@"strTitle"];
    }
    if ([key isEqualToString:@"_created_at"])
    {
        NSData *strcreatedAt = value;
        [self setValue:strcreatedAt forKey:@"strcreatedAt"];
    }
    if ([key isEqualToString:@"content"])
    {
        NSString *strContent = value;
        [self setValue:strContent forKey:@"strContent"];
    }
        if ([key isEqualToString:@"hot_comment"])
    {
        DZHotCommentModel *hotModel =value;
        [self setValue:hotModel forKey:@"hotModel"];
        
    }
    if ([key isEqualToString:@"_incrs"])
    {
        NSDictionary *dicValue = value;
        DZIncrsModel *incrsModel = [DZIncrsModel DZIncrsModelWithDict:dicValue];
        [self setValue:incrsModel forKey:@"incrsModel"];
        
    }

    
}
-(void)setStrcreatedAt:(NSString *)strcreatedAt
{
    if (!strcreatedAt)
    {
        _strcreatedAt = nil;
    }
    NSString *strTempT = [strcreatedAt stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSString *strTemp = [strTempT substringWithRange:NSMakeRange(0, 10)];  
    _strcreatedAt = strTemp;
}
@end
