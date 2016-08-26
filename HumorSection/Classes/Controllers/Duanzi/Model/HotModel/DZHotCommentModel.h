//
//  hotCommentModel.h
//  New——
//
//  Created by 洋洋 on 16/7/27.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZHotCommentModel : NSObject
/**author 评论名*/
@property (nonatomic ,copy ) NSString *strAuthor;
/**message 评论内容*/
@property (nonatomic ,copy ) NSString *strMessage;
/**like  点赞次数*/
@property (nonatomic ,copy ) NSString *strLike;
+(instancetype)DZHotCommentModelWithDict:(NSDictionary *)dicData;
@end
