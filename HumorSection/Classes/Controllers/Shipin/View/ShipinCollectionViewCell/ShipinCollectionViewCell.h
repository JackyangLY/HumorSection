//
//  ShipinCollectionViewCell.h
//  HumorSection
//
//  Created by 洋洋 on 16/7/13.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYDataModel.h"
@interface ShipinCollectionViewCell : UITableViewCell
/** 当前cell显示的数据 */
@property (nonatomic, strong) LYDataModel *lyDataModel;


+(instancetype)cellWithTableView:(UITableView *)tableview;
@end
