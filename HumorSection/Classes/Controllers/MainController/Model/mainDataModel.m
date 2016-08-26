//
//  mainDataModel.m
//  HumorSection
//
//  Created by 洋洋 on 16/8/10.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "mainDataModel.h"

@implementation mainDataModel
+(instancetype)mainDataModelWithDict:(NSDictionary *)dict
{
    mainDataModel *model = [[self alloc]init];
    model.StrCover = dict[@"cover"];
    model.StrTitle = dict[@"title"];
    model.StrUrl = dict[@"url"];
    return model;
}
@end
