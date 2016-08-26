//
//  DataModel.m
//  json解析
//
//  Created by 洋洋 on 16/8/4.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "SHFDataModel.h"

@implementation SHFDataModel
//+(instancetype)DatamodelWithDictionary:(NSDictionary *)dict
//{
//    DataModel *dataModel = [[DataModel alloc]init];
//       dataModel = dict[@"data"];
//    NSDictionary *dictData = dict[@"data"];
//   // for (NSInteger index = 0; index < ; <#increment#>) {
//     //   <#statements#>
//   // }
//    return dataModel;
//}
//-(id) init{
//    if (self=[super init]) {
//        //初始化数组
//        //self.stories=[NSMutableArray array];
//        //self.top_stories=[NSMutableArray array];
//        //self.arrMuData = [NSMutableArray array];
//    }
//    return self;
//}

#if 1
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    /**<#name#>*/
    return  self;
    
}
+(instancetype)SHFDataModelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
        /**user_name 用户名*/
    if ([key isEqualToString:@"user_name"])
    {
        NSString *strUserName = value;
        [self setValue:strUserName forKey:@"StrUser_name"];
    }
        /**avatar 用户头像*/
    if ([key isEqualToString:@"avatar"])
    {
        NSString *StrAvatar = value;
        [self setValue:StrAvatar forKey:@"StrAvatar"];
    }
    
    /**title 标题*/
    if ([key isEqualToString:@"title"]) {
        NSString *strTitle= value;
        [self setValue:strTitle forKey:@"StrTitle"];
    }
        /**_created_at 发表时间*/
    if ([key isEqualToString:@"_created_at"])
    {
        NSData *strcreatedAt = value;
        [self setValue:strcreatedAt forKey:@"StrCreated_at"];
    }
    if ([key isEqualToString:@"content"])
    {
        NSString *strContent = value;
        [self setValue:strContent forKey:@"strContent"];
    }
    if ([key isEqualToString:@"hot_comment"])
    {
        NSDictionary *dicValue = value;
        SHFHotCommentModel *StrHot_comment =[SHFHotCommentModel HotCommentModelWithDict:dicValue];
        [self setValue:StrHot_comment forKey:@"StrHot_comment"];
        
    }
    if ([key isEqualToString:@"tag"])
    {
        NSString *StrTag = value;
        [self setValue:StrTag forKey:@"StrTag"];
    }
    if ([key isEqualToString:@"imgUrl"])
    {
        NSString *strImgUrl = value;
        
        [self setValue:strImgUrl forKey:@"strImgUrl"];
    }
    if ([key isEqualToString:@"media_data"])
    {
        NSArray *arrValue = [NSArray array];
        arrValue = value;
        for (NSDictionary *dict in arrValue)
        {
            SHFMediaDataModel *StrMdeia_data  = [SHFMediaDataModel MediaDataModelWithDict:dict];
            [self setValue:StrMdeia_data forKey:@"StrMdeia_data"];
        }
     }

    
}
#endif
@end
