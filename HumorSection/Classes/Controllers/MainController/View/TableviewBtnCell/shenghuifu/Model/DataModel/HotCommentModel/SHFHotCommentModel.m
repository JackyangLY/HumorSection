//
//  HotCommentModel.m
//  json解析
//
//  Created by 洋洋 on 16/8/4.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "SHFHotCommentModel.h"
@implementation SHFHotCommentModel

+(instancetype)HotCommentModelWithDict:(NSDictionary *)dict
{
    SHFHotCommentModel *model = [[self alloc]init];
    model.StrAutor = dict[@"author"];
    model.StrAutorId = dict[@"author_id"];
    model.StrMessage = dict[@"message"];
    model.StrLike = dict[@"like"];
    model.StrDislike = dict[@"dislike"];
    model.StrID = dict[@"_id"];
    
    NSDictionary *dictAvator = dict[@"extra"];
    model.StrExtra = dictAvator[@"avatar"];
    return model;
}
@end
