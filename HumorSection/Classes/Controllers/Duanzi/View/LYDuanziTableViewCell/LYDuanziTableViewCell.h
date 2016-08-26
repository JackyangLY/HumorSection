//
//  LYDuanziTableViewCell.h
//  HumorSection
//
//  Created by 洋洋 on 16/7/21.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZDataModel.h"
@interface LYDuanziTableViewCell : UITableViewCell
@property (nonatomic ,copy) DZDataModel *dzdataModel;
+(instancetype)LYDuanziTableViewCellWithTableview:(UITableView *)tableview;

@end
