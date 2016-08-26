//
//  ButtonNameModels.m
//  ShowSmile
//
//  Created by 洋洋 on 16/7/8.
//  Copyright © 2016年 Jack_yangyang. All rights reserved.
//存放按钮数据的模型

#import "ButtonNameModels.h"

@implementation ButtonNameModels
+(instancetype )modelWithDicitionary : (NSDictionary *)dict
{
    ButtonNameModels *buttonModels = [ButtonNameModels new];
    buttonModels.strName = dict[@"name"];
    buttonModels.strIcon = dict[@"icon"];
    buttonModels.strTconHeight =dict[@"iconHeight"];
    return buttonModels;
}
@end
