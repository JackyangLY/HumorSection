//
//  ButtonNameModels.h
//  ShowSmile
//
//  Created by 洋洋 on 16/7/8.
//  Copyright © 2016年 Jack_yangyang. All rights reserved.
//存放按钮数据的模型

#import <Foundation/Foundation.h>

@interface ButtonNameModels : NSObject
/**button的名字*/
@property (nonatomic ,copy) NSString *strName;
/**button的图片*/
@property (nonatomic ,copy) NSString *strIcon;
/**button的高亮图片*/
@property (nonatomic ,copy) NSString *strTconHeight;
/**构造方法*/
+(instancetype )modelWithDicitionary : (NSDictionary *)dict;
@end
