//
//  LYLengxiaohuaViewController.m
//  HumorSection
//
//  Created by 洋洋 on 16/7/20.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "LYLengxiaohuaViewController.h"
#import "LYMCJZYTableViewCell.h"
#import "AFNetworking.h"
#define UCLXHURL @"http://napi.uc.cn/3/classes/topic/lists/%E6%97%A5%E5%BC%8F%E5%86%B7%E7%AC%91%E8%AF%9D?"
@interface LYLengxiaohuaViewController ()<UITableViewDataSource,UITableViewDelegate>

/**存放数据的数组*/
@property(nonatomic,copy) NSMutableArray *ArrMuLYDataModel;

@property (nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSString *StrMAx_pos;

@property(nonatomic,copy) NSArray *ArrMAx_pos;

@property(nonatomic,assign) NSInteger Intindex;
@end


@implementation LYLengxiaohuaViewController

-(NSMutableArray *)ArrMuLYDataModel
{
    if (!_ArrMuLYDataModel)
    {
        NSString *StrPath = [[NSBundle mainBundle]pathForResource:@"LXHData" ofType:@"plist"];
        NSArray *arrMain = [NSArray arrayWithContentsOfFile:StrPath];
        NSMutableArray *arrMuMain = [NSMutableArray arrayWithCapacity:arrMain.count];
        for (NSDictionary *dict in arrMain)
        {
            SHFDataModel *model = [SHFDataModel SHFDataModelWithDictionary:dict];
            [arrMuMain addObject:model];
        }
        
        _ArrMuLYDataModel = [arrMuMain copy];    }
    return _ArrMuLYDataModel;
}
-(NSArray *)ArrMAx_pos
{
    if (!_ArrMAx_pos)
    {
        _ArrMAx_pos = @[@"9999999999999",@"1434441988390",@"1445963056226",@"1435951339044",@"1441119064289",@"1455583011881",@"1433734837860",@"1437901106137",@"1446335508573",@"1435870841677",@"1428390652463",@"1462093586238",@"1424053291757",@"1444864841623",@"1432555358543",@"1430662871400",@"1425290889978",@"1454911627340",@"1446191389469",@"1421160726672",@"1462312867835",@"1434555218702",@"1421132022134",@"1433243062376",@"1438898774359",@"1424275188777",@"1442591647482",@"1443876148605",@"1446059914197",@"1465340288053",@"1440979441575",@"1455985566371",@"1425816369187",@"1429602223774"];
    }
    return _ArrMAx_pos;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadBasicSetting];
    
    NSString *strBar = @"如以下内容给您带来不适，请绕行";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:strBar preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                      {
                          //点击按钮的响应事件；
                      }]];
    
    /**弹出提示框*/
    [self presentViewController:alert animated:true completion:nil];

}
#pragma mark 加载默认设置
-(void)loadBasicSetting
{
    self.title =  @"冷笑话";
    self.Intindex = 0;
    self.StrMAx_pos = self.ArrMAx_pos[0];
    self.view.userInteractionEnabled = YES;
    UITableView *tableView = [UITableView new];
    tableView.frame = self.view.bounds;
    tableView.estimatedRowHeight= 100;
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    //tableView.contentInset = UIEdgeInsetsMake(0, 0, -84, 0);
    tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    //[self requestInformation];
}
#pragma  mark 请求数据
-(void)requestInformation
{
    NSDictionary *param = @{@"_app_id":@"hottopic",
                            @"_size":@"10",
                            @"_fetch":@"1",
                            @"_max_pos":self.StrMAx_pos
                            };
    //@"_select":@"like_start%2Cdislike_start%2Ctitle%2Ctag%2Cmedia_data%2Clist_info%2Ccontent%2Cavatar%2Cuser_name%2Cis_hot%2Chot_comment%2Ccomment_total%2Coriginal%2Ctv_duration"
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [manager GET:UCLXHURL parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSArray *arrData = responseObject[@"data"];
         _ArrMuLYDataModel = [NSMutableArray arrayWithCapacity:arrData.count];
         NSMutableArray *muarr = [NSMutableArray arrayWithCapacity:arrData.count];
         for (NSDictionary *dict in arrData)
         {
             SHFDataModel *model = [SHFDataModel SHFDataModelWithDictionary:dict];
             [muarr addObject:model];
             //  //NSlog(@"%s\n%@",__func__, model.description);
         }
         __weak typeof(self) weakSelf = self;
         dispatch_async(dispatch_get_main_queue(), ^
                        {
                            _ArrMuLYDataModel = [muarr copy];
                            
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
//当停止拖动,将要减速的时候,判断是否需要加载更多
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat tablecontenoffsetY = -65.5;
    if (self.tableView.contentOffset.y < tablecontenoffsetY)
    {
        self.Intindex += 1;
        /**打印此方法*/
        //NSLog(@"%s\n%@",__func__,scrollView);
        if (self.Intindex > self.ArrMAx_pos.count-1)
        {
            
        }
        else
        {
            self.StrMAx_pos = self.ArrMAx_pos[self.Intindex];
            [self requestInformation];
        }
        
    }
    else
    {
        
    }
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ArrMuLYDataModel.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出模型
    SHFDataModel *model = self.ArrMuLYDataModel[indexPath.row];
    LYMCJZYTableViewCell *cell =[LYMCJZYTableViewCell LYMCJZYTableViewCellWithTableView:tableView];
    //覆盖数据
    cell.shfDataModel = model;
    return cell;
}

@end
