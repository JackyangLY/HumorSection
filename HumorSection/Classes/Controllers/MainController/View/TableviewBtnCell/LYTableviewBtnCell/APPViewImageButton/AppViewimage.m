//
//  AppViewimage.m
//
//
//  Created by 洋洋 on 16/6/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "AppViewimage.h"
@interface AppViewimage()
{
    __weak IBOutlet UIButton *_imageButton;
    
    __weak IBOutlet UILabel *_labelName;
}
@end
@implementation AppViewimage

+(instancetype)appView
{
    AppViewimage *view =[[[NSBundle mainBundle]loadNibNamed:@"AppViewimage" owner:nil options:nil]firstObject];
    return view;
}
//*xib加载完后
-(void)awakeFromNib
{
    [super awakeFromNib];
}
/**重写setDictInformation*/
-(void)setDictInformation:(NSDictionary *)dictInformation
{
    _dictInformation = [dictInformation copy];
    [_imageButton setBackgroundImage:[UIImage imageNamed:dictInformation[@"imgBtn"]]forState:UIControlStateNormal];
    [_imageButton.layer setCornerRadius:5.0];
    [_imageButton.layer setBorderColor:[UIColor blackColor].CGColor];
    [_imageButton.layer setBorderWidth:1.0];
    [_imageButton.layer setMasksToBounds:YES];

    [_labelName setText:dictInformation[@"title"]];
    

}

- (IBAction)ActionButton
{
    /**打印此方法*/
    //NSLog(@"%s\n %@",__func__,_labelName.text);

    [[NSNotificationCenter defaultCenter] postNotificationName:@"AppViewimageBtnName" object:self userInfo:@{@"BtnName":_labelName.text}];

}

@end
