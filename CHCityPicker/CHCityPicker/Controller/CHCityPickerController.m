//
//  CHCityPickerController.m
//  CHCityPicker
//
//  Created by arnoldxiao on 16/1/13.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import "CHCityPickerController.h"
#import "CHCityListSystemCell.h"
#import "CHCityListCustomCell.h"
#import "CHCityListHeaderView.h"
#import "CHCityList.h"
#import "CHCity.h"
#import "NSString+Enhance.h"

@interface CHCityPickerController () <UITableViewDataSource, UITableViewDelegate>
{
    /**
     *  CHCityList实体，包含一个citys属性，NSArray<CHCity *> *
     */
    CHCityList *cityList;
    
    /**
     *  CHCity实体，包含cityID/cityName/pinyin三个属性
     */
    CHCity *city;
    
    /**
     *  城市字典，key为A-Z字母组合(不排除个别字母不存在)，value为城市拼音首字母大写为key的城市实体组成的数组
     */
    NSMutableDictionary *cityDict;
    
    /**
     *  A-Z的字母组合，部分字母没有！！
     */
    NSMutableArray *capitalArray;
}

@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL didConstraint;

@property (nonatomic,copy) NSMutableArray<NSString *> *historyCitys;
@property (nonatomic,copy) NSMutableArray<NSString *> *hotCitys;

@end

@implementation CHCityPickerController

- (instancetype)init {
    if (self = [super init]) {
        [self initCityData];
    }
    return self;
}

- (void)initCityData {
    NSString *contents = [NSString stringWithFileName:@"cityList" type:@"json"];
    NSError *error = nil;
    cityList = [[CHCityList alloc] initWithString:contents error:&error];
    
    cityDict = [NSMutableDictionary dictionaryWithCapacity:26];
    capitalArray = [NSMutableArray arrayWithCapacity:26];
    for (int i = 65; i <= 90; i++) {
        NSString *tmpKey = [NSString stringwithInt:i needUpper:YES];
        NSMutableArray *tmpValue = [NSMutableArray array];
        for (int j = 0; j < cityList.citys.count; j++) {
            city = [[CHCity alloc] initWithDictionary:(NSDictionary *)cityList.citys[j] error:&error];
            NSString *cityCapital = [city.pinyin capitalNeedUpper:YES];
            if ([cityCapital isEqualToString:tmpKey]) {
                [tmpValue addObject:city];
            }
        }
        if (tmpValue.count) {
            [cityDict setObject:tmpValue forKey:tmpKey];
            [capitalArray addObject:tmpKey];
        }
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
        [self.tableView autoPinEdgesToSuperviewEdges];
        self.didConstraint = YES;
    }
    [super updateViewConstraints];
}

#pragma mark  - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3 + capitalArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < 3) {
        return 1;
    }
    
    NSString *capital = capitalArray[section - 3];
    return [[cityDict objectForKey:capital] count];
}

- (CHCityListBaseCell *)tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= 3) {
        CHCityListSystemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierSystem];
        if (!cell) {
            cell = [[CHCityListSystemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierSystem];
        }
        NSString *capital = capitalArray[indexPath.section - 3];
        CHCity *tmpCity = [cityDict objectForKey:capital][indexPath.row];
        [cell configCellTitle:tmpCity.cityName];
        return cell;
    }
    
    CHCityListCustomCell *cell = nil;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {                        //  TODO：定位
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierCustom];
        if (!cell) {
            cell = [CHCityListCustomCell cellWithCityNames:@[@"深圳"]];
        }
        [cell configCellTitle];
    } else if (indexPath.section == 1 || indexPath.section == 2) {
        NSArray<NSString *> *array = (indexPath.section == 1) ? self.historyCitys : self.hotCitys;        //  indexPath.section == 2  -->  hot
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierCustom];
        if (!cell) {
            cell = [CHCityListCustomCell cellWithCityNames:array];
        }
        [cell configCellTitle];
    }
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView indexPath:indexPath];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self tableView:tableView indexPath:indexPath] calcRowHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *title;
    switch (section) {
        case 0:
            title = @"定位城市";
            break;
            
        case 1:
            title = @"最近访问城市";
            break;
            
        case 2:
            title = @"热门城市";
            break;
            
        default:
            title = capitalArray[section - 3];
            break;
    }
    CHCityListHeaderView *view = [CHCityListHeaderView headerViewWithStyle:HeaderViewStyleSection];
    [view configTitle:title];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

#pragma mark - Close - Event
- (void)closeButtonPressed:(UIButton *)btn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Lazy Loading
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
        _tableView.tableHeaderView = [CHCityListHeaderView headerViewWithStyle:HeaderViewStyleTableView];
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
