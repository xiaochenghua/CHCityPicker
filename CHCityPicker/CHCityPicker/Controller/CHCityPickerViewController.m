//
//  CHCityPickerViewController.m
//  CHCityPicker
//
//  Created by APP on 16/1/7.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import "CHCityPickerViewController.h"
#import "CHCityListSystemCell.h"
#import "CHCityListCustomCell.h"
#import "chcityListHeaderView.h"
#import "NSString+Enhance.h"

@interface CHCityPickerViewController () <UITableViewDataSource, UITableViewDelegate>
{
    /**
     *  内部是字典，key分别有id,city,pinyin
     */
    NSArray *citys;
    
    /**
     *  内部字典，key分别从A-Z，value是数组对象，分别存放着对应的citys内部的字典
     */
    NSMutableArray *cityGroupArray;
    
    /**
     *  Cell类型
     */
    CHCityListCellType listCellType;
    
    /**
     *  索引值数组
     */
    NSMutableArray *indexArray;
}

/**
 *  关闭按钮
 */
@property (nonatomic, strong) UIButton *closeButton;

/**
 *  tableView
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 *  是否已经布局
 */
@property (nonatomic, assign) BOOL didConstraint;

/**
 *  历史访问城市列表
 */
@property (nonatomic, copy) NSMutableArray<NSString *> *historyCitys;
/**
 *  热门城市列表
 */
@property (nonatomic, copy) NSMutableArray<NSString *> *hotCitys;
@end

@implementation CHCityPickerViewController

- (instancetype)init {
    if (self = [super init]) {
        [self initCityData];
    }
    return self;
}

/**
 *  初始化城市数据
 */
- (void)initCityData {
    NSString *file = [NSString stringWithFileName:@"cityList" type:@"json"];
    citys = [self analysisJSONDataWithString:file];
    cityGroupArray = [NSMutableArray arrayWithCapacity:citys.count];
    NSMutableDictionary *tmpDict = [NSMutableDictionary dictionaryWithCapacity:26];
    indexArray = [NSMutableArray array];
    for (int i = 65; i <= 90; i++) {
        NSString *tmpKey = [NSString stringwithInt:i needUpper:YES];        //  tmpKey - A
        NSMutableArray *tmpValue = [NSMutableArray array];
        for (int j = 0; j < citys.count; j++) {
            NSString *capital = [citys[j][@"pinyin"] capitalNeedUpper:YES];
            if (capital == tmpKey) {
                [tmpValue addObject:citys[j]];
            }
        }
        [tmpDict setObject:tmpValue forKey:tmpKey];
        if ([[tmpDict objectForKey:tmpKey] count]) {
            [indexArray addObject:tmpKey];
        } else {
            [tmpDict removeObjectForKey:tmpKey];
        }
        [cityGroupArray addObject:tmpDict];
    }
}

/**
 *  根据JSON文件内容，解析JSON
 *
 *  @param jsonString JSON文件内容
 *
 *  @return 字典内部的数组，解析失败则返回nil
 */
- (NSArray *)analysisJSONDataWithString:(NSString *)jsonString {
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if ([object isKindOfClass:[NSDictionary class]]) {
        return [(NSDictionary *)object objectForKey:@"citys"];
    } else {
        NSLog(@"JSON解析失败！！");
        return nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorCodeWithRGB(0xf0f0f0);
    self.navigationItem.title = @"请选择城市";
    [self setupLayout];
}

- (void)setupLayout {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.closeButton];
    [self.view addSubview:self.tableView];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
    if (!self.didConstraint) {
        //  tableView - AutoLayout
        [self.tableView autoPinEdgesToSuperviewEdges];
        
        self.didConstraint = YES;
    }
    [super updateViewConstraints];
}

#pragma mark  - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3 + cityGroupArray.count;            //  定位城市 + 最近访问城市 + 热门城市 +
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < 3) {
        return 1;
    }
    return [self getArrayWithArray:cityGroupArray section:section].count;
}

- (NSArray *)getArrayWithArray:(NSArray *)array section:(NSInteger)section {
    id tmpobj1 = [cityGroupArray objectAtIndex:section - 3];
    if ([tmpobj1 isKindOfClass:[NSDictionary class]]) {
        NSString *capital = [NSString stringwithInt:(int)section + 62 needUpper:YES];
        id tmpobj2 = [tmpobj1 objectForKey:capital];
        if ([tmpobj2 isKindOfClass:[NSArray class]]) {
            return tmpobj2;
        } else {
            NSLog(@"1--获取JSON内部数据失败");
            return nil;
        }
    } else {
        NSLog(@"2--获取JSON内部数据失败");
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView indexPath:indexPath];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CHCityListBaseCell *cell = [self tableView:tableView indexPath:indexPath];
    return [cell calcRowHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
//    if (section >= 3) {
//        NSString *key = [NSString stringwithInt:(int)(section + 62) needUpper:YES];
//        if (![indexArray containsObject:key]) {
//            return nil;
//        }
//    }
    
    CHCityListHeaderView *view = [[CHCityListHeaderView alloc] initWithHeaderViewStyle:HeaderViewStyleSection];
    NSString *title;
    if (section == 0) {
        title = @"定位城市";
    } else if (section == 1) {
        title = @"最近访问城市";
    } else if (section == 2) {
        title = @"热门城市";
    } else {
        title = indexArray[section - 3];
    }
    [view configTitle:title];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

/**
 *  返回Cell
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return
 */
- (CHCityListBaseCell *)tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= 3) {
        CHCityListSystemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierSystem];
        if (!cell) {
            cell = [[CHCityListSystemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierSystem];
        }
        NSArray *tmpArray = [self getArrayWithArray:cityGroupArray section:indexPath.section];
        NSString *title = [tmpArray[indexPath.row] objectForKey:@"city"];
        [cell configCellTitle:title];
        return cell;
    }
    
    CHCityListCustomCell *cell = nil;
    if (indexPath.section == 0) {                        //  TODO：定位
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierCustom];
        if (!cell) {
            cell = [[CHCityListCustomCell alloc] initWithCityNames:@[@"深圳"]];
        }
        [cell configCellTitle];
    } else if (indexPath.section == 1 || indexPath.section == 2) {
        NSArray<NSString *> *array = (indexPath.section == 1) ? self.historyCitys : self.hotCitys;        //  indexPath.section == 2  -->  hot
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierCustom];
        if (!cell) {
            cell = [[CHCityListCustomCell alloc] initWithCityNames:array];
        }
        [cell configCellTitle];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Close - Event
- (void)closeButtonPressed:(UIButton *)btn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 懒加载
- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] init];
        [_closeButton setImage:[UIImage imageNamed:@"btn_close"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_closeButton sizeToFit];
    }
    return _closeButton;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableHeaderView = [[CHCityListHeaderView alloc] initWithHeaderViewStyle:HeaderViewStyleTableView];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = kColor(orangeColor);
    }
    return _tableView;
}

- (NSMutableArray<NSString *> *)historyCitys {
    if (!_historyCitys) {
        _historyCitys = [NSMutableArray arrayWithObjects:@"上海", @"广州", @"深圳", @"南昌", nil];
    }
    return _historyCitys;
}

- (NSMutableArray<NSString *> *)hotCitys {
    if (!_hotCitys) {
        _hotCitys = [NSMutableArray arrayWithObjects:@"上海", @"北京", @"广州", @"深圳", @"天津", @"杭州", @"南京", @"武汉", @"成都", @"沈阳", @"西安", nil];
    }
    return _hotCitys;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
