//
//  HotCommentModel.h
//  json解析
//
//  Created by 洋洋 on 16/8/4.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHFHotCommentModel : NSObject


/**"author":"鹰过留痕"*/
@property(nonatomic,strong) NSString *StrAutor;
/**"author_id":"570055466"*/
@property(nonatomic,strong) NSString *StrAutorId;
/**"message":"这缜密的构思，精彩的语言，超凡的想象力，感觉我的高考作文在它面前就是坨shi"*/
@property(nonatomic,strong) NSString *StrMessage;
/**"like":333*/
@property(nonatomic,strong) NSString *StrLike;
/**"dislike":0*/
@property(nonatomic,strong) NSString *StrDislike;
/**"_id":"21461939"*/
@property(nonatomic,strong) NSString *StrID;

@property(nonatomic,strong) NSString *StrExtra;



+(instancetype)HotCommentModelWithDict :(NSDictionary *)dict;
@end
