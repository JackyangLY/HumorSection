//
//  MediaDataModel.h
//  json解析
//
//  Created by 洋洋 on 16/8/5.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHFMediaDataModel : NSObject

@property(nonatomic,strong) NSString *StrWif_img_url;
@property(nonatomic,strong) NSString *Strmobile_img_url;
+(instancetype)MediaDataModelWithDict:(NSDictionary *)dict;
@end
