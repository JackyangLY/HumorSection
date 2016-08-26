//
//  DZIncrsModel.h
//  HumorSection
//
//  Created by 洋洋 on 16/8/10.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZIncrsModel : NSObject
//like": 6577,
@property(nonatomic,strong) NSString *StrLike;
//"dislike": 337,
@property(nonatomic,strong) NSString *StrDislike;
//"fb_wuliao": 1,
@property(nonatomic,strong) NSString *StrFbWuliao;
//"share": 960,
@property(nonatomic,strong) NSString *StrShare;
+(instancetype)DZIncrsModelWithDict:(NSDictionary *)dicData;

@end
