//
//  MediaDataModel.m
//  json解析
//
//  Created by 洋洋 on 16/8/5.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "SHFMediaDataModel.h"

@implementation SHFMediaDataModel
+(instancetype)MediaDataModelWithDict:(NSDictionary *)dict
{
     SHFMediaDataModel *model = [[self alloc]init];
    //StrWif_img_url;wifi_img_url
    //Strmobile_img_url;mobile_img_url
    model.StrWif_img_url = dict[@"wifi_img_url"];
    model.Strmobile_img_url = dict[@"mobile_img_url"];
    return model;
}
@end
