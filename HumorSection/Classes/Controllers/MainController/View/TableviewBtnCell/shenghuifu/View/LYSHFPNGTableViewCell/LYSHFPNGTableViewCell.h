//
//  LYSHFTableViewCell.h
//  HumorSection
//
//  Created by 洋洋 on 16/8/6.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHFDataModel.h"
@interface LYSHFPNGTableViewCell : UITableViewCell
@property(nonatomic,strong)SHFDataModel *shfDataModel;
+(instancetype)LYSHFTableViewCellWithTableView:(UITableView *)tableview;
@end
