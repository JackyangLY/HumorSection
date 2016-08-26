//
//  LYGIFTableViewCell.h
//  HumorSection
//
//  Created by 洋洋 on 16/8/7.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHFDataModel.h"

@interface LYGIFTableViewCell : UITableViewCell

@property(nonatomic,strong)SHFDataModel *shfDataModel;
+(instancetype)LYGIFTableViewCellWithTableView:(UITableView *)tableview;

@end
