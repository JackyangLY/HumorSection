//
//  ShipinViewController.m
//  HumorSection
//
//  Created by 洋洋 on 16/7/13.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//
#import "AFNetworking.h"
#import "ShipinViewController.h"
#import "ShipinCollectionViewCell.h"
#import "UIScrollView+QCLRefresh.h"
#import "LYInfoModel.h"
#import "LYDataModel.h"

#define  BaseUrl @"http://qiqu.uc.cn/api/video?id="

#define ShipinURL @"http://napi.uc.cn/3/classes/topic/lists/%E5%8F%91%E7%8E%B0%E8%A7%86%E9%A2%91%E5%88%97%E8%A1%A8?"

@interface ShipinViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)AVPlayerViewController *avplayerController;

/**存放数据的数组*/
@property(nonatomic,copy) NSMutableArray *ArrMuLYDataModel;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic ,strong) QCLHeaderView *headerView;

@property (nonatomic ,strong) QCLFooterView *footerView;

@property(nonatomic,copy) NSArray *ArrMax_pos;

@property(nonatomic,strong) NSString *StrMax_pos;

@property(nonatomic,assign) NSInteger Intindex;


@end

@implementation  ShipinViewController
-(NSMutableArray *)ArrMuLYDataModel
{
    if (!_ArrMuLYDataModel)
    {
        NSString *StrPath = [[NSBundle mainBundle]pathForResource:@"SPData" ofType:@"plist"];
        NSArray *arrMain = [NSArray arrayWithContentsOfFile:StrPath];
        NSMutableArray *muarr = [NSMutableArray array];
        NSMutableArray *muarrdata = [NSMutableArray array];
        for (NSDictionary *dict in arrMain)
        {
            LYInfoModel *model = [LYInfoModel LYInfoModelWithDict:dict];
            [muarr addObject:model];
            LYDataModel *modeldata = [LYDataModel LYDataModelWithDict:dict];
            [muarrdata addObject:modeldata];
         }
        _ArrMuLYDataModel = [muarrdata copy];
    }
    return _ArrMuLYDataModel;
}
-(NSArray*)ArrMax_pos
{
    if (!_ArrMax_pos)
    {
        _ArrMax_pos = @[@"9999999999999",@"1469508549451",@"1459473231846",@"1452058906550",@"1450858363800",@"1452147175476",@"1452147014405",@"1452147014405",@"1452146899215",@"1452140076699",@"1452140035597",@"1452139986791",@"1452139939970",@"1452139877490",@"1452139989081",@"1521398798211",@"1521398798221",@"1521398798212"];
        
    }
    return _ArrMax_pos;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"视频";
    self.Intindex = 0;
    self.StrMax_pos = self.ArrMax_pos[0];
    [self loadBasicSetting];
    //[self requestInformation];
    
}
-(void)loadBasicSetting
{
    self.view.userInteractionEnabled = YES;
    UITableView *tableView = [UITableView new];
    tableView.frame = self.view.bounds;
    tableView.estimatedRowHeight= 100;
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    //self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 22, 0);
    tableView.showsVerticalScrollIndicator = NO;
    //  __weak typeof(self) weakSelf = self;
    self.headerView = [self.tableView addHeaderRefresh:^(UIView *view) {
        
        //NSlog(@"开始刷新");
    }];
    
    
}

#pragma  mark 请求数据
-(void)requestInformation
{
    NSDictionary *param = @{@"_app_id":@"hottopic",
                            @"_size":@"10",
                            @"_fetch":@"1",
                            @"_fetch_incrs":@"1",
                            @"_max_pos":self.StrMax_pos,
                            };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [manager GET:ShipinURL parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSArray *arr  = responseObject[@"data"];
         NSMutableArray *muarr = [NSMutableArray array];
         NSMutableArray *muarrdata = [NSMutableArray array];
         for (NSDictionary *dict in arr)
         {
             LYInfoModel *model = [LYInfoModel LYInfoModelWithDict:dict];
             [muarr addObject:model];
             LYDataModel *modeldata = [LYDataModel LYDataModelWithDict:dict];
             [muarrdata addObject:modeldata];
             
         }
         __weak typeof(self) weakSelf = self;
         dispatch_async(dispatch_get_main_queue(), ^
                        {
                            _ArrMuLYDataModel = [muarrdata copy];
                            
                            [weakSelf.tableView reloadData];
                        });
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         // //NSlog(@"%s\n%@",__func__,error);
         NSString *strBar = @"网络连接错误";
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:strBar preferredStyle:  UIAlertControllerStyleAlert];
         
         [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                           {
                               //点击按钮的响应事件；
                           }]];
         
         /**弹出提示框*/
         [self presentViewController:alert animated:true completion:nil];
     }];

}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ArrMuLYDataModel.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出模型
    LYDataModel *model = self.ArrMuLYDataModel[indexPath.row];
    ShipinCollectionViewCell *cell =[ShipinCollectionViewCell cellWithTableView:tableView];
    //覆盖数据
    cell.lyDataModel = model;
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat tablecontenoffsetY = -65.5;
    //[self.tableView reloadData];
    if (self.tableView.contentOffset.y < tablecontenoffsetY)
    {
        /**打印此方法*/
       // //NSlog(@"%s\n%@",__func__,scrollView);
            }
    else
    {
            //[self.tableView reloadData];
    }
    
}
//当停止拖动,将要减速的时候,判断是否需要加载更多
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat tablecontenoffsetY = -65.5;
    if (self.tableView.contentOffset.y < tablecontenoffsetY)
    {
        self.Intindex += 1;
        if (self.Intindex > self.ArrMax_pos.count-1)
        {
            
        }else
        {
           
            self.StrMax_pos =self.ArrMax_pos[self.Intindex];
            /**打印此方法*/
            ////NSlog(@"%s\n%@",__func__,self.StrMax_pos);
            [self requestInformation];
        }
        
    }
    else
    {
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
       [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 取出模型
        LYDataModel *model = self.ArrMuLYDataModel[indexPath.row];
    
    /**初始化视图控制器对象*/
    self.avplayerController = [[AVPlayerViewController alloc] init];
    
    NSString *StrUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,model.StrId];
    /**设置播放器的对象*/
    AVPlayer *player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:StrUrl]];
    self.avplayerController.player = player;
    /**设置样式*/
    self.avplayerController.videoGravity = AVLayerVideoGravityResizeAspect;
    /**播放*/
    [self.avplayerController.player play];
    [self presentViewController:self.avplayerController animated:YES completion:^
     {
         /**打印此方法*/
         //NSlog(@"%s",__func__);
         
     }];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //NSlog(@"%s",__func__);
}
-(void)dealloc
{
    //NSlog(@"%s",__func__);
}
@end
