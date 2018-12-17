//
//  SearcherController.m
//  MyShopping
//
//  Created by 惠上科技 on 2018/3/16.
//  Copyright © 2018年 惠上科技. All rights reserved.
//

#import "SearcherController.h"
#import "FMTagsView.h"
#import "UIView+Frame.h"
#import <Masonry.h>
@interface SearcherController ()<FMTagsViewDelegate,UISearchBarDelegate>
@property (weak, nonatomic) FMTagsView *tagsView;
@property (weak, nonatomic) FMTagsView *recommendView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *recommendArray;
@property (strong,nonatomic)NSMutableArray * hotDataArray;
@end
@implementation SearcherController{
    UISearchBar *_searchbar;
    UILabel *_tipLab;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索";
    self.view.backgroundColor = [UIColor whiteColor];
    _hotDataArray = [NSMutableArray arrayWithCapacity:0];
    _recommendArray = [NSMutableArray arrayWithCapacity:0];
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    [self setUI];
    [self hotRecommend];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_back_normal"] style:UIBarButtonItemStyleDone target:self action:@selector(backItemClick)];
    self.navigationItem.leftBarButtonItem = backItem;
}

-(void)backItemClick{
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --------热门推荐
-(void)hotRecommend{
    [_recommendArray addObjectsFromArray:@[@"拖鞋",@"毛尖",@"牙刷",@"洗面奶",@"羽绒服",@"大衣",@"音响",@"手机"]];
    _recommendView.tagsArray = self.recommendArray;
}

#pragma mark --------setUI
-(void)setUI{
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(15, 69, self.view.frame.size.width - 30, 30)];;
    [self.view addSubview:searchBar];
    _searchbar = searchBar;
    _searchbar.layer.cornerRadius = 15;
    _searchbar.layer.masksToBounds = YES;
    _searchbar.tintColor = [UIColor whiteColor];
    searchBar.placeholder = @"搜索分类";
    searchBar.delegate = self;
    searchBar.backgroundColor = [UIColor lightGrayColor];
//    searchBar.backgroundImage = [self imageWithColor:[UIColor clearColor] size:searchBar.bounds.size];
    [searchBar setImage:[UIImage imageNamed:@"首页-搜索"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    UITextField *textField = [searchBar valueForKey:@"_searchField"];
    textField.font = [UIFont systemFontOfSize:11];
    [textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    textField.textColor = [UIColor whiteColor];
    textField.backgroundColor = [UIColor clearColor];
    
    FMTagsView *tagsView = [[FMTagsView alloc]initWithFrame:CGRectMake(10, 135, self.view.frame.size.width-20, 50)];
    _tagsView = tagsView;
    _tagsView.contentInsets = UIEdgeInsetsZero;
    _tagsView.tagInsets = UIEdgeInsetsMake(5, 15, 5, 15);
    _tagsView.tagBorderWidth = 1;
    _tagsView.tagcornerRadius = 2;
    _tagsView.tagBorderColor = [UIColor lightGrayColor];
    _tagsView.tagSelectedBorderColor = [UIColor lightGrayColor];
    _tagsView.tagBackgroundColor = [UIColor whiteColor];
    _tagsView.lineSpacing = 10;
    _tagsView.interitemSpacing = 10;
    _tagsView.tagFont = [UIFont systemFontOfSize:14];
    _tagsView.tagTextColor = [UIColor grayColor];
    _tagsView.tagSelectedBackgroundColor = _tagsView.tagBackgroundColor;
    _tagsView.tagSelectedTextColor = _tagsView.tagTextColor;
    _tagsView.delegate = self;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if([user objectForKey:@"historyArray"]){
        self.dataArray = [[NSMutableArray alloc]initWithArray:[user objectForKey:@"historyArray"]];
    }
    _tagsView.tagsArray = self.dataArray;
    [_tagsView.collectionView reloadData];
    UILabel *tipLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 130, self.view.frame.size.width, 15)];
    [self.view addSubview:tipLab];
    _tipLab = tipLab;
    tipLab.text = @"暂无历史记录";
    tipLab.textColor = [UIColor blackColor];
    tipLab.font = [UIFont systemFontOfSize:12];
    tipLab.textAlignment = NSTextAlignmentCenter;
    tipLab.hidden = YES;
    if(self.dataArray.count == 0) {
        _tipLab.hidden = NO;
        _tagsView.hidden = YES;
    }else if(self.dataArray.count > 0){
        _tipLab.hidden = YES;
        _tagsView.hidden = NO;
    }
    _tagsView.height = _tagsView.collectionView.collectionViewLayout.collectionViewContentSize.height + 10;
    [self.view addSubview:tagsView];

    UILabel *historyLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 110, 100, 16)];
    [self.view addSubview:historyLab];
    historyLab.text = @"搜索历史";
    historyLab.textColor = [UIColor darkGrayColor];
    historyLab.font = [UIFont systemFontOfSize:16];

    UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-30, 110, 15, 15)];
    [self.view addSubview:deleteBtn];
    [deleteBtn setBackgroundImage:[UIImage imageNamed:@"dustbin"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];

    UILabel *hotRecommendLab = [[UILabel alloc]init];
    [self.view addSubview:hotRecommendLab];
    [hotRecommendLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tagsView.mas_bottom).offset(10);
        make.left.equalTo(historyLab.mas_left);
        make.height.equalTo(@(16));
    }];
    hotRecommendLab.text = @"热门推荐";
    hotRecommendLab.textColor = [UIColor darkGrayColor];
    hotRecommendLab.font = [UIFont systemFontOfSize:16];

    FMTagsView *recommendView = [[FMTagsView alloc]init];
    [self.view addSubview:recommendView];
    _recommendView = recommendView;
    [recommendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hotRecommendLab.mas_bottom).offset(10);
        make.left.equalTo(_tagsView.mas_left);
        make.right.equalTo(_tagsView.mas_right);
        make.height.equalTo(@(150));
    }];
    recommendView.contentInsets = UIEdgeInsetsZero;
    recommendView.tagInsets = UIEdgeInsetsMake(5, 15, 5, 15);
    recommendView.tagBorderWidth = 1;
    recommendView.tagcornerRadius = 2;
    recommendView.tagBorderColor = [UIColor lightGrayColor];
    recommendView.tagSelectedBorderColor = [UIColor lightGrayColor];
    recommendView.tagBackgroundColor = [UIColor whiteColor];
    recommendView.lineSpacing = 10;
    recommendView.interitemSpacing = 10;
    recommendView.tagFont = [UIFont systemFontOfSize:14];
    recommendView.tagTextColor = [UIColor grayColor];
    recommendView.tagSelectedBackgroundColor = _tagsView.tagBackgroundColor;
    recommendView.tagSelectedTextColor = _tagsView.tagTextColor;
    recommendView.delegate = self;
}

-(void)deleteBtnClick{
    _tagsView.hidden = YES;
    [_dataArray removeAllObjects];
    _tagsView.tagsArray = _dataArray;
    [_tagsView.collectionView reloadData];
    _tagsView.height = _tagsView.collectionView.collectionViewLayout.collectionViewContentSize.height + 10;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user removeObjectForKey:@"historyArray"];
    [user synchronize];
    _tipLab.hidden = NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (_searchbar.text.length) {
        [_searchbar resignFirstResponder];
        if ([self.dataArray containsObject:_searchbar.text]) {
            [self.dataArray removeObject:_searchbar.text];
        }
        [self.dataArray insertObject:_searchbar.text atIndex:0];
        _tagsView.tagsArray = self.dataArray;
        [_tagsView.collectionView reloadData];
        _tagsView.height = _tagsView.collectionView.collectionViewLayout.collectionViewContentSize.height + 10;
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:self.dataArray forKey:@"historyArray"];
        [user synchronize];
        _tipLab.hidden = YES;
        _tagsView.hidden = NO;
        NSLog(@"进入商品搜索界面");
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

//取消searchbar背景色
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
#pragma mark - ......::::::: FMTagsViewDelegate :::::::......
- (void)tagsView:(FMTagsView *)tagsView didSelectTagAtIndex:(NSUInteger)index {
    [_searchbar resignFirstResponder];
    if ([tagsView isEqual:_tagsView]) {
        NSString *selectKey = self.dataArray[index];
        [self.dataArray removeObject:selectKey];
        [self.dataArray insertObject:selectKey atIndex:0];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:self.dataArray forKey:@"historyArray"];
        [user synchronize];
        _searchbar.text = selectKey;
        NSLog(@"进入搜索界面");
    }else if([tagsView isEqual:_recommendView]){
        NSString *selectKey = self.recommendArray[index];
        _searchbar.text = selectKey;
        if ([self.dataArray containsObject:selectKey]) {
            [self.dataArray removeObject:selectKey];
        }
        [self.dataArray insertObject:_searchbar.text atIndex:0];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:self.dataArray forKey:@"historyArray"];
        [user synchronize];
        NSLog(@"进入搜索界面");
    }
    _tagsView.hidden = NO;
    _tagsView.tagsArray = self.dataArray;
    [_tagsView.collectionView reloadData];
    _tagsView.height = _tagsView.collectionView.collectionViewLayout.collectionViewContentSize.height + 10;
    _tipLab.hidden = YES;
}
@end
