//
//  DuanziViewController.m
//  ShowSmile
//
//  Created by 洋洋 on 16/7/8.
//  Copyright © 2016年 Jack_yangyang. All rights reserved.
//段子控制器

#import "DuanziViewController.h"
#import "LYDuanziTableViewCell.h"
#import "AFNetworking.h"
#import "DZDataModel.h"
#import "UIScrollView+QCLRefresh.h"

#define UCDZURL @"http://napi.uc.cn/3/classes/topic/lists/%E6%AE%B5%E5%AD%90"

@interface DuanziViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, strong) UITableView *tableView;
/**数据*/
@property (nonatomic, copy) NSMutableArray *ArrMuDatas;

@property (nonatomic ,strong) QCLHeaderView *headerView;

@property (nonatomic ,strong) QCLFooterView *footerView;

@property(nonatomic,copy) NSArray *ArrMax_pos;

@property(nonatomic,strong) NSString *StrMax_pos;

@property(nonatomic,assign) NSInteger Intindex;
@end

@implementation DuanziViewController
-(NSArray*)ArrMax_pos
{
    if (!_ArrMax_pos)
    {
        _ArrMax_pos = @[@"9999999999999",@"1441873450309",@"1467696277342",@"1453857793940",@"1440058001445",@"1440132041898",@"1438867338498",@"1447347014505",@"1438958446276",@"1446875120091",@"1453331427414",@"1448508466811",@"1449932804690",@"1465104078417",@"1441157370437",@"1452951645015",@"1446592583611",@"1448835750866",@"1461505327861",@"1465659022743",@"1465572693807",@"1461824306351",@"1451451930570",@"1457687451622",@"1456850581662",@"1451792412142",@"1443379944496",@"1464967843126",@"1457223254682",@"1469706535463",@"1459132631212",@"1448617756432",@"1469875838168",@"1459317314693",@"1460222894979",@"1442492201368",@"1443379361348",@"1455598851482",@"1441721281789",@"1458660083400",@"1448037123338",@"1459009544651",@"1454860409351",@"1443530344716",@"1442397198112",@"1458972479083",@"1450723509577",@"1455397072520",@"1464555996114",@"1455936222316",@"1440691769669",@"1456236014342",@"1461931767176",@"1459949213523",@"1452906797768",@"1466991534367",@"1457657570386",@"1454475819417",@"1466694290041",@"1461404581609",@"1464926401452",@"1467264604527",@"1456696335740",@"1459382321341",@"1468522974760",@"1456195844788",@"1459984670564",@"1464373023931",@"1440048345931",@"1470445865726",@"1467103496725",@"1447730226657",@"1455913062293",@"1455232927247",@"1463367070069",@"1462206086377",@"1442701847639",@"1447680440848",@"1440103603561",@"1464860496400",@"1460698099149",@"1454215155035",@"1447987946713",@"1443456124068"];
    }
    return _ArrMax_pos;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadBasicSetting];
    self.title = @"段子";
    self.Intindex = 0;
    self.headerView = [self.tableView addHeaderRefresh:^(UIView *view) {
        
        ////NSlog(@"开始刷新");
    }];
}

-(void)loadBasicSetting;
{
    self.StrMax_pos = self.ArrMax_pos[0];
    UITableView *DuanziTableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    DuanziTableview.estimatedRowHeight = 40;
    [self.view addSubview:DuanziTableview];
    DuanziTableview.dataSource = self;
    DuanziTableview.delegate = self;
    self.tableView = DuanziTableview;
    DuanziTableview.showsVerticalScrollIndicator = NO;
      //[self requestInfoMation];
}
-(NSMutableArray *)ArrMuDatas
{
    if (!_ArrMuDatas)
    {
        NSString *StrPath = [[NSBundle mainBundle]pathForResource:@"DZData" ofType:@"plist"];
        NSArray *arrMain = [NSArray arrayWithContentsOfFile:StrPath];
        NSMutableArray *arrMuMain = [NSMutableArray arrayWithCapacity:arrMain.count];
        for (NSDictionary *dict in arrMain)
        {
            DZDataModel *model = [DZDataModel DatamodelWithDictionary:dict];
            [arrMuMain addObject:model];
        }
        
        _ArrMuDatas = [arrMuMain copy];
    }
    return _ArrMuDatas;
}

-(void)requestInfoMation
{
    NSDictionary *dict = @{@"_app_id":@"hottopic",
                           @"_size":@"10",
                           @"_fetch":@"1",
                           @"_fetch_incrs":@"1",
                           @"_fetch_total":@"1",
                           @"_max_pos":self.StrMax_pos
                           };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [manager GET:UCDZURL parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSArray *arrData = responseObject[@"data"];
         _ArrMuDatas = [NSMutableArray arrayWithCapacity:arrData.count];
         NSMutableArray *muarr = [NSMutableArray arrayWithCapacity:arrData.count];
         for (NSDictionary *dict in arrData)
         {
             DZDataModel *model = [DZDataModel DatamodelWithDictionary:dict];
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
        if (self.Intindex > self.ArrMax_pos.count-1)
        {
            
        }else
        {
            self.StrMax_pos =self.ArrMax_pos[self.Intindex];
            /**打印此方法*/
            //NSlog(@"%s\n%@",__func__,scrollView);
            [self requestInfoMation];
        }

    }
    else
    {

    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ArrMuDatas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //LYDuanziTableViewCell *cell = [LYDuanziTableViewCell LYDuanziTableViewCellWithTableview:tableView];
    LYDuanziTableViewCell  *viewcell = [LYDuanziTableViewCell LYDuanziTableViewCellWithTableview:tableView];
    [viewcell setDzdataModel:self.ArrMuDatas[indexPath.row]];
    return viewcell;
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
