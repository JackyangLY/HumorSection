//
//  mainTableviewcell.h
//  HumorSection
//
//  Created by 洋洋 on 16/8/10.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainDataModel.h"
@interface mainTableviewcell : UITableViewCell
@property(nonatomic ,copy) mainDataModel *mainModel;

+(instancetype)cellWithTableView:(UITableView *)tableview;
@end
