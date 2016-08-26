//
//  DZIncrsModel.m
//  HumorSection
//
//  Created by 洋洋 on 16/8/10.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "DZIncrsModel.h"

@implementation DZIncrsModel
+(instancetype)DZIncrsModelWithDict:(NSDictionary *)dicData
{
    if (dicData == nil || [dicData isKindOfClass:[NSNull class]]) return nil;
    DZIncrsModel *model = [[self alloc]init];
    model.StrLike  = (NSString *)dicData[@"like"];
    model.StrDislike = dicData[@"dislike"];
    model.StrFbWuliao = dicData[@"fb_wuliao"];
    model.StrShare = dicData[@"share"];
    return model;
}
@end
