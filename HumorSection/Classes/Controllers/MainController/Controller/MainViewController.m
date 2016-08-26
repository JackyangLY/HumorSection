//
//  ViewController.m
//  HumorSection
//
//  Created by 洋洋 on 16/7/13.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//首页主控制器

#import "MainViewController.h"
#import "LYDetailWEBViewController.h"
#import "LYImageScrollView.h"
#import "MeirijingxunViewController.h"
#import "ShipinViewController.h"
#import "DuanziViewController.h"
#import "GerenzhongxinViewController.h"
#import "ButtonSetscrollView.h"
#import "LYTabBarViewController.h"
#import "LYMeiripaihangbangVC.h"
#import "LYShenhuifuController.h"
#import "LYMimiViewController.h"
#import "LYGIFtuViewController.h"
#import "LYMengchongjizhongying.h"
#import "LYLengxiaohuaViewController.h"
#import "LYAppButtomView.h"
#import "mainTableviewcell.h"
#import "AFNetworking.h"

#define URL @"http://napi.uc.cn/3/classes/topic/search?_app_id=hottopic&_fetch=1&_fetch_incrs=1&_sort=_lists.score%3Adesc&_lists=_lists.list_id%3A%22index_promotion%22&_select=url%2Ctitle%2Ccover%2Ctag%2Cdesc%2Ccomment_total%2Cincrs_flag%2Clist_name%2Cpost_type"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,weak) ButtonSetscrollView *buttonSetView;
/**首页轮播图*/
@property (nonatomic ,strong ) LYImageScrollView *imageViewDisplay;
/**点击的次数*/
@property (nonatomic ,assign ) NSInteger num;
/**装label的view*/
@property (nonatomic , strong) UIView *labelView;
/**数据*/
@property (nonatomic, copy) NSMutableArray *ArrMuDatas;

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MainViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor cyanColor];
    [self loadBasicSetting];
    self.title = @"首页";
}

#pragma  mark 懒加载 imageViewDisplay
-(LYImageScrollView *) imageViewDisplay
{
    if (!_imageViewDisplay)
    {
        /**设置frame*/
        CGRect frame = CGRectMake(0, 0, LYSCREEN_WIDTH, LYSCREEN_WIDTH * 0.45);
          NSArray *imageArray = @[@"001.jpg", @"002.jpg", @"003.jpg", @"004.jpg", @"005.jpg"];
         /**初始化控件*/
        LYImageScrollView *imageViewDisplay = [LYImageScrollView LYImageScrollViewWithFrame:frame WithImages:imageArray];
        /**设定轮播时间*/
        imageViewDisplay.scrollInterval = 2;
        /**图片滚动的时间*/
         imageViewDisplay.animationInterVale = 0.6;
        /**把该视图添加到相应的父视图上*/
        _imageViewDisplay = imageViewDisplay;

    }
    return _imageViewDisplay;
}
-(void)loadBasicSetting
{
    /**添加 Tableview*/
    CGFloat maintabelveiwHeight = LYSCREEN_HEIGHT/2 - 10;

    UITableView *mainTabelview  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, LYSCREEN_WIDTH, maintabelveiwHeight) style:UITableViewStylePlain];
    //UITableView *mainTabelview  = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];

    [self.view addSubview:mainTabelview];
    mainTabelview.dataSource = self;
    mainTabelview.delegate = self;
    self.tableView = mainTabelview;
    mainTabelview.rowHeight = LYSCREEN_WIDTH *0.16;
    mainTabelview.showsVerticalScrollIndicator = NO;
    mainTabelview.tableHeaderView = self.imageViewDisplay;
    //[self requestInfoMation];
    /**创建APPbutton视图*/
    
    LYAppButtomView *appButtonView = [[LYAppButtomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(mainTabelview.frame), LYSCREEN_WIDTH, maintabelveiwHeight+20)];
    appButtonView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:appButtonView];
    //mainTabelview.tableFooterView = appButtonView;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChangedWithNotification:) name:@"AppViewimageBtnName" object:nil];
   
    /**创建ScrollView视图*/
    ButtonSetscrollView *buttonSetView = [[ButtonSetscrollView alloc]init];

    [buttonSetView setFrame:CGRectMake(0,LYSCREEN_HEIGHT * 0.87, LYSCREEN_WIDTH , 78)];
    [self.view addSubview:buttonSetView];
    _buttonSetView = buttonSetView;
    
    [self readlabelView];
    //测试
    UIButton *TestButton = [[UIButton alloc]init];
    //TestButton.frame = CGRectMake(8, 540, 40, 40);
    TestButton.frame = CGRectMake(8, LYSCREEN_HEIGHT * 0.8, LYSCREEN_WIDTH * 0.09, LYSCREEN_WIDTH * 0.09);
    TestButton.backgroundColor = [UIColor yellowColor];
    [TestButton setImage:[UIImage imageNamed:@"click"] forState:UIControlStateNormal];
    [self.view addSubview:TestButton];
    TestButton.layer.cornerRadius = 15;
    [TestButton addTarget:self action:@selector(buttonHideView) forControlEvents:UIControlEventTouchUpInside];
    
    __weak typeof(self) selfWeak = self;
    [buttonSetView setBlockClickChangeAction:^(UIButton *button)
    {
       
        [selfWeak JudegeButtonValue:button];
    }];
}
-(NSMutableArray *)ArrMuDatas
{
    if (!_ArrMuDatas)
    {
        NSString *StrPath = [[NSBundle mainBundle]pathForResource:@"MainData" ofType:@"plist"];
        NSArray *arrMain = [NSArray arrayWithContentsOfFile:StrPath];
        NSMutableArray *arrMuMain = [NSMutableArray arrayWithCapacity:arrMain.count];
        for (NSDictionary *dict in arrMain)
        {
            mainDataModel *model = [mainDataModel mainDataModelWithDict:dict];
            [arrMuMain addObject:model];
        }
        
        _ArrMuDatas = [arrMuMain copy];
    }
       return _ArrMuDatas;
}
-(void)requestInfoMation
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSArray *arrData = responseObject[@"data"];
          _ArrMuDatas = [NSMutableArray arrayWithCapacity:arrData.count];
         NSMutableArray *muarr = [NSMutableArray arrayWithCapacity:arrData.count];
         for (NSDictionary *dict in arrData)
         {
              mainDataModel *model = [mainDataModel mainDataModelWithDict:dict];
             [muarr addObject:model];
             //  //NSlog(@"%s\n%@",__func__, model.description);
         }
         __weak typeof(self) weakSelf = self;
         dispatch_async(dispatch_get_main_queue(), ^
                        {
                            _ArrMuDatas = [muarr copy];
                            [weakSelf.tableView reloadData];
                        });
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         // //NSlog(@"%s\n%@",__func__,error);
     }];
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ArrMuDatas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出模型
    mainDataModel *model = self.ArrMuDatas[indexPath.row];
    mainTableviewcell *cell =[mainTableviewcell cellWithTableView:tableView];
    //覆盖数据
    cell.mainModel = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //mainDataModel *model = self.ArrMuDatas[indexPath.row];
    //LYDetailWEBViewController *detailWebVC = [[LYDetailWEBViewController alloc]init];
    LYMeiripaihangbangVC  *MRPHController = [LYMeiripaihangbangVC new];
    [self presentViewController:MRPHController animated:YES completion:nil];
    //NSLog(@"%s\n%@",__func__,model.StrUrl);
//    if (model.StrUrl)
//    {
//        detailWebVC.StrURL = model.StrUrl;
//        [self presentViewController:detailWebVC animated:YES completion:nil];
//    }
//    else
//    {
//         LYMeiripaihangbangVC  *MRPHController = [LYMeiripaihangbangVC new];
//        [self presentViewController:MRPHController animated:YES completion:nil];
    //}
}


/**选择下半部分View上的button*/
-(void)textDidChangedWithNotification:(NSNotification *)noti
{
    LYMeiripaihangbangVC  *MRPHController = [LYMeiripaihangbangVC new];
    LYShenhuifuController  *SHFController = [LYShenhuifuController new];
    LYMimiViewController *MMController = [LYMimiViewController new];
    LYGIFtuViewController  *GIFController = [LYGIFtuViewController new];
    LYMengchongjizhongying  *MCJZYController = [LYMengchongjizhongying new];
    LYLengxiaohuaViewController  *LXHController = [LYLengxiaohuaViewController new];

     NSString *btnName = noti.userInfo[@"BtnName"];
    if ([btnName isEqualToString:@"每日排行榜"])
    {
        [self presentViewController:MRPHController animated:YES completion:nil];
    }
    else if([btnName isEqualToString:@"神回复"])
    {
        //[self presentViewController:SHFController animated:YES completion:nil];
        [self.navigationController pushViewController:SHFController animated:YES];
    }
    else if([btnName isEqualToString:@"秘密"])
    {
       // [self presentViewController:MMController animated:YES completion:nil];
        [self.navigationController pushViewController:MMController animated:YES];
    }
    else if([btnName isEqualToString:@"GIF图"])
    {
        //[self presentViewController:GIFController animated:YES completion:nil];
        [self.navigationController pushViewController:GIFController animated:YES];
        
    }
        else if([btnName isEqualToString:@"萌宠联盟"])
    {
       // [self presentViewController:MCJZYController animated:YES completion:nil];
        [self.navigationController pushViewController:MCJZYController animated:YES];
    }
        else if([btnName isEqualToString:@"冷笑话"])
    {
        //[self presentViewController:LXHController animated:YES completion:nil];
          [self.navigationController pushViewController:LXHController animated:YES];
    }
}

/**判断下面的button*/
-(void)JudegeButtonValue:(UIButton *)button
{
    /**创建各个视图的控制器*/
    //  MeirijingxunViewController *meirijingxuan = [MeirijingxunViewController new];
    ShipinViewController  *SpController = [ShipinViewController new];
    DuanziViewController  *DzController = [DuanziViewController new];
//    JiaoliuluntanViewController *Jlltcontroller = [JiaoliuluntanViewController new];
    GerenzhongxinViewController  *GrzxController = [GerenzhongxinViewController new];
     NSInteger index = button.tag;
    if (index == 1)
    {
        LYTabBarViewController *TabBar = [LYTabBarViewController new];
        [self presentViewController:TabBar animated:YES completion:nil];
        //[self presentViewController:meirijingxuan animated:YES completion:nil];
        //[self.navigationController pushViewController:TabBar animated:YES];
    }
    else if(index == 2)
    {
        //ShipinViewController  *SpController = [ShipinViewController new];
       // [self presentViewController:SpController animated:YES completion:nil];
        [self.navigationController pushViewController:SpController animated:YES];
    }
    else if (index == 3)
    {
       // [self presentViewController:DzController animated:YES completion:nil];
        [self.navigationController pushViewController:DzController animated:YES];
    }
    else if (index == 4)
    {
        //            GerenzhongxinViewController  *GrzxController = [GerenzhongxinViewController new];
        //[self presentViewController:GrzxController animated:YES completion:nil];
         [self.navigationController pushViewController:GrzxController animated:YES];
    }

}
-(void )readlabelView
{
    UILabel *dianLbl = [UILabel new];
    dianLbl.text = @"点";
    dianLbl.textColor = [UIColor blueColor];
    dianLbl.font = [UIFont systemFontOfSize:12.0 weight:9.0];
    //dianLbl.frame = CGRectMake(8, 510, 20,20);
    dianLbl.frame = CGRectMake(8, LYSCREEN_HEIGHT*0.8 -30, 20, 20);
    [self.view addSubview:dianLbl];
    //TestButton.frame = CGRectMake(8, 540, 40, 40);
    //TestButton.frame = CGRectMake(8, LYSCREEN_HEIGHT * 0.78, 40, 40);
    UILabel *woLbl = [UILabel new];
    woLbl.text = @"我";
    woLbl.textColor = [UIColor blueColor];
    woLbl.font = [UIFont systemFontOfSize:12.0 weight:9.0];
    //woLbl.frame = CGRectMake(23, 515, 20, 20);
    woLbl.frame = CGRectMake(23, LYSCREEN_HEIGHT*0.8 - 25, 20, 20);
    [self.view addSubview:woLbl];
    
    UILabel *yinLbl = [UILabel new];
    yinLbl.text = @"隐";
    yinLbl.textColor = [UIColor blueColor];
    yinLbl.font = [UIFont systemFontOfSize:12.0 weight:9.0];
    //yinLbl.frame = CGRectMake(38, 520, 20, 20);
    yinLbl.frame = CGRectMake(38, LYSCREEN_HEIGHT*0.8 - 20, 20, 20);
    [self.view addSubview:yinLbl];
    UILabel *cangLbl = [UILabel new];
    cangLbl.text = @"身";
    cangLbl.textColor = [UIColor blueColor];
    cangLbl.font = [UIFont systemFontOfSize:12.0 weight:9.0];
    //cangLbl.frame = CGRectMake(48, 530, 20, 20);
    cangLbl.frame = CGRectMake(43, LYSCREEN_HEIGHT*0.8 - 5, 20, 20);
    [self.view addSubview:cangLbl];
    
}
-(void)buttonHideView
{
    _num++;
    if (_num %2 == 1)
    {
        
        [UIView beginAnimations:@"test" context:nil];
        [UIView setAnimationDuration:0.5];
        _buttonSetView.frame = CGRectMake(LYSCREEN_WIDTH, LYSCREEN_HEIGHT *0.87, LYSCREEN_WIDTH, 78);
        [UIView commitAnimations];
    }
    else
    {
        [UIView beginAnimations:@"test" context:nil];
            [UIView setAnimationDuration:0.5];

        _buttonSetView.frame = CGRectMake(0,LYSCREEN_HEIGHT * 0.87, LYSCREEN_WIDTH, 78);
        [UIView commitAnimations];
        
    }

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
- (void)dealloc {
    // 如果当前类有添加监听器, 那么在当前对象从内存中销毁的时候就要把这个监听器移除
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
