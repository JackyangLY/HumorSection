//
//  MeirijingxunViewController.m
//  ShowSmile
//
//  Created by 洋洋 on 16/7/8.
//  CopyLeft © 2016年 Jack_yangyang. All Lefts reserved.
//每日精选控制器

#import "MeirijingxunViewController.h"
#import "MainViewController.h"
#import "LYSHFPNGTableViewCell.h"
#import "SHFDataModel.h"
#import "AFNetWorking.h"
#define  URL @"http://napi.uc.cn/3/classes/topic/lists/%E9%A6%96%E9%A1%B5%E7%B2%BE%E9%80%89%E5%88%97%E8%A1%A8"

@interface MeirijingxunViewController ()<UITableViewDataSource,UITableViewDelegate>
/**存放数据的数组*/
@property(nonatomic,copy) NSMutableArray *ArrMuDatas;

@property (nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSString *StrMAx_pos;

@property(nonatomic,copy) NSArray *ArrMAx_pos;

@property(nonatomic,assign) NSInteger Intindex;

@end

@implementation MeirijingxunViewController

-(NSArray *)ArrMAx_pos
{
    if (!_ArrMAx_pos)
    {
        _ArrMAx_pos = @[@"1458039003489",@"1441119064289",@"1455583011881",@"1433734837860",@"1437901106137",@"1446335508573",@"1435870841677",@"1428390652463",@"1462093586238",@"1424053291757",@"1444864841623",@"1432555358543",@"1430662871400",@"1425290889978",@"1454911627340",@"1446191389469",@"1421160726672",@"1462312867835",@"1434555218702",@"1421132022134",@"1433243062376",@"1438898774359",@"1424275188777",@"1445963056226",@"1442591647482",@"1443876148605",@"1446059914197",@"1434441988390",@"1465340288053",@"1440979441575",@"1455985566371",@"1425816369187",@"1429602223774",@"1435951339044"];
    }
    return _ArrMAx_pos;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"精选";
    self.Intindex = 0;
    self.StrMAx_pos = self.ArrMAx_pos[0];
    [self.view setBackgroundColor:[UIColor purpleColor]];
    /**给添加nav item添加item*/
    UIBarButtonItem *LeftItem=[[UIBarButtonItem alloc] initWithTitle:@"<返回" style:UIBarButtonItemStylePlain target:self action:@selector(LeftBtn:)];
    [LeftItem setTintColor:[UIColor blackColor]];
    LeftItem.width = 100;
    self.navigationItem.leftBarButtonItem=LeftItem;
    UITableView *tableView = [UITableView new];
    tableView.frame = self.view.bounds;
    tableView.estimatedRowHeight= 100;
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;

  //  [self requestInfoMation];
}
-(NSMutableArray *)ArrMuDatas
{
    if (!_ArrMuDatas)
    {
        NSString *StrPath = [[NSBundle mainBundle]pathForResource:@"MRJXData" ofType:@"plist"];
        NSArray *arrMain = [NSArray arrayWithContentsOfFile:StrPath];
        NSMutableArray *arrMuMain = [NSMutableArray arrayWithCapacity:arrMain.count];
        for (NSDictionary *dict in arrMain)
        {
            SHFDataModel *model = [SHFDataModel SHFDataModelWithDictionary:dict];
            [arrMuMain addObject:model];
        }
        
        _ArrMuDatas = [arrMuMain copy];
    }
    return _ArrMuDatas;
}


-(void)requestInfoMation
{
    NSDictionary *param = @{@"_app_id":@"hottopic",
                            @"_size":@"10",
                            @"_fetch":@"1",
                            @"_max_pos":self.StrMAx_pos
                            };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    [manager GET:URL parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSArray *arrData = responseObject[@"data"];

         _ArrMuDatas = [NSMutableArray arrayWithCapacity:arrData.count];
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
        /**打印此方法*/
        //NSLog(@"%s\n%@",__func__,scrollView);
        if (self.Intindex > self.ArrMAx_pos.count-1)
        {
            
        }
        else
        {
            self.StrMAx_pos = self.ArrMAx_pos[self.Intindex];
            [self requestInfoMation];
        }
        
    }
    else
    {
        
    }
    
}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ArrMuDatas.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出模型
    SHFDataModel *model = self.ArrMuDatas[indexPath.row];
    LYSHFPNGTableViewCell *cell =[LYSHFPNGTableViewCell LYSHFTableViewCellWithTableView:tableView];
    //覆盖数据
    cell.shfDataModel = model;
    return cell;
}

#pragma  mark 返回按钮
-(void)LeftBtn:(UIButton *)button
{

    [self dismissVC];
}

-(void)dismissVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)dealloc
{
    //NSLog(@"%s",__func__);
}

@end
