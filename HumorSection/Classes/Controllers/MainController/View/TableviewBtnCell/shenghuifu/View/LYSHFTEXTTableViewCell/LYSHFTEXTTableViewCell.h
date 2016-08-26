//
//  LYSHFTEXTTableViewCell.h
//  HumorSection
//
//  Created by 洋洋 on 16/8/8.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SHFDataModel.h"
@interface LYSHFTEXTTableViewCell : UITableViewCell

@property(nonatomic,strong)SHFDataModel *shfDataModel;
+(instancetype)LYSHFTEXTTableViewCellWithTableView:(UITableView *)tableview;

@end
