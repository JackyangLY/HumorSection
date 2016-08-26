//
//  hotCommentModel.m
//  New——
//
//  Created by 洋洋 on 16/7/27.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "DZHotCommentModel.h"

@implementation DZHotCommentModel

+(instancetype)DZHotCommentModelWithDict:(NSDictionary *)dicData
{
    if (dicData == nil || [dicData isKindOfClass:[NSNull class]]) return nil;
    DZHotCommentModel *comment = [self new];
    comment.strAuthor =dicData [@"author"];
    comment.strLike = dicData [@"like"];
    comment.strMessage = dicData [@"message"];
    return comment;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"message"])
    {
        NSString *strMessage = value;
        [self setValue:strMessage forKey:@"strMessage"];
    }
}
@end
