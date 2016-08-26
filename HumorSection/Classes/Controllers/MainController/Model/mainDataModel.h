//
//  mainDataModel.h
//  HumorSection
//
//  Created by 洋洋 on 16/8/10.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mainDataModel : NSObject
@property(nonatomic,strong) NSString *StrCover;
@property(nonatomic,strong) NSString *StrTitle;
@property(nonatomic,strong) NSString *StrUrl;
+(instancetype)mainDataModelWithDict:(NSDictionary *)dict;
@end
