//
//  DataModel.h
//  New——
//
//  Created by 洋洋 on 16/7/27.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZHotCommentModel.h"
#import "DZIncrsModel.h"

@interface DZDataModel : NSObject
/**user_name 用户名*/
@property (nonatomic ,copy) NSString *strUserName;
/**avatar 用户头像*/
@property (nonatomic ,copy) NSString *strUrlAvatar;
/**title 内容标题*/
@property (nonatomic ,copy) NSString *strTitle;
/**time 发表时间*/
@property (nonatomic ,strong) NSString *strcreatedAt;
/**content 发表内容*/
@property (nonatomic ,strong) NSString *strContent;
/**message 评论内容*/
@property (nonatomic ,copy ) NSString *strMessage;
/**like  点赞次数*/
@property (nonatomic ,copy ) NSString *strLike;
/**hotModel 模型*/
@property (nonatomic ,strong)DZHotCommentModel *dzhotModel;
/**DZIncrsModel 模型*/
@property (nonatomic ,strong) DZIncrsModel *incrsModel;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)DatamodelWithDictionary:(NSDictionary *)dict;

@end

