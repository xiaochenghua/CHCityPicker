//
//  CHCityPickerController.m
//  CHCityPicker
//
//  Created by arnoldxiao on 16/1/13.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import "CHCityPickerController.h"
#import "CHCityListCell.h"
#import "CHCityListHeaderView.h"
#import "CHCityIndexView.h"
#import "CHButton.h"
#import "CHCity.h"
#import "NSString+Enhance.h"

@interface CHCityPickerController () <UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate>
{
    /**
     *  是否已经布局
     */
    BOOL didConstraint;
    
    /**
     *  城市字典，key为A-Z字母组合(不排除个别字母不存在)，value为城市拼音首字母大写为key的城市实体组成的数组
     */
    NSMutableDictionary *formatCityDict;
    
    /**
     *  A-Z的字母组合，部分字母没有！！
     */
    NSMutableArray *initialsArray;
    
    /**
     *  导航视图数组，@[@"@", @"&", @"$"] + capitalArray，前三个元素分别表示定位城市、最近访问城市和热门城市
     */
    NSMutableArray *indexArray;
    
    /**
     *  城市名集合
     */
    NSMutableArray<NSString *> *cityNames;
    
    /**
     *  城市拼音集合
     */
    NSMutableArray<NSString *> *cityPinyins;
    
    /**
     *  含有@"_"的城市拼音集合
     */
    NSMutableArray<NSString *> *specialCityPinyins;
    
    /**
     *  搜索关键字
     */
    NSString *searchWords;
    
    /**
     *  搜索结果集合
     */
    NSMutableArray *searchResultList;
    
    /**
     *  城市名和拼音的字典，拼音作为key，城市名作为value
     */
    NSMutableDictionary *cityMappingDict;
}

@property (nonatomic, strong) UIButton             *closeButton;
@property (nonatomic, strong) UITableView          *tableView;

@property (nonatomic, strong) UISearchController   *searchController;
@property (nonatomic, strong) NSLayoutConstraint   *constraint;
@property (nonatomic, copy  ) ReturnCityNameBlock  returnCityNameBlock;

@property (nonatomic, strong) CHCityIndexView *indexView;

@property (nonatomic, copy  ) NSMutableArray<NSString *> *historyCitys;
@property (nonatomic, copy  ) NSMutableArray<NSString *> *hotCitys;

@end

@implementation CHCityPickerController

- (instancetype)init {
    if (self = [super init]) {
        //  大幅减少初始化耗时，提高性能
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initCityData];
        });
    }
    return self;
}

- (void)initCityData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cityList" ofType:@"plist"];
    
    NSDictionary *originalCityDict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *originalCityArray = [originalCityDict objectForKey:[originalCityDict allKeys].firstObject];
    
    formatCityDict = [NSMutableDictionary dictionaryWithCapacity:26];
    initialsArray = [NSMutableArray arrayWithCapacity:26];
    cityMappingDict = [NSMutableDictionary dictionaryWithCapacity:originalCityArray.count];
    
    NSError *error = nil;
    NSMutableArray<NSNumber *> *tmpArray = [NSMutableArray arrayWithCapacity:originalCityArray.count];
    
    for (int i = 65; i <= 90; i++) {
        
        NSString *tmpKey = [NSString stringwithInt:i];
        NSMutableArray<CHCity *> *tmpValue = [NSMutableArray array];
        
        for (int j = 0; j < originalCityArray.count; j++) {
            if ([tmpArray containsObject:[NSNumber numberWithInt:j]]) {
                continue;
            }
            CHCity *city = [[CHCity alloc] initWithDictionary:originalCityArray[j] error:&error];
            NSString *cityCapital = [city.pinyin capital];
            if ([cityCapital isEqualToString:tmpKey]) {
                [tmpValue addObject:city];
                [cityMappingDict setObject:city.cityName forKey:city.pinyin];
                [tmpArray addObject:[NSNumber numberWithInt:j]];
            }
        }
        
        if (tmpValue.count) {
            [formatCityDict setObject:tmpValue forKey:tmpKey];
            [initialsArray addObject:tmpKey];
        }
    }
    
    cityNames = [NSMutableArray arrayWithCapacity:originalCityArray.count];
    cityPinyins = [NSMutableArray arrayWithCapacity:originalCityArray.count];
    specialCityPinyins = [NSMutableArray array];
    
    for (int i = 0; i < originalCityArray.count; i++) {
        CHCity *city = [[CHCity alloc] initWithDictionary:originalCityArray[i] error:&error];
        [cityNames addObject:city.cityName];
        [cityPinyins addObject:city.pinyin];
        if ([city.pinyin containsString:@"_"]) {
            [specialCityPinyins addObject:city.pinyin];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorCodeWithRGB(0xf0f0f0);
    [self setupLayout];
}

- (void)setupLayout {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.closeButton];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.indexView];
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
    if (!didConstraint) {
        self.constraint = [[self.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, marginX)] lastObject];
        
        [self.indexView autoSetDimensionsToSize:CGSizeMake(navigationWidth, self.view.frame.size.height - 64)];
        [self.indexView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.indexView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:64];
        
        didConstraint = YES;
    }
    
    [super updateViewConstraints];
}

#pragma mark  - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.searchController.active) {
        return 1;
    } else {
        return 3 + initialsArray.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.searchController.active) {
        return searchResultList.count;
    } else {
        if (section < 3) {
            return 1;
        }
        
        NSString *capital = initialsArray[section - 3];
        return [[formatCityDict objectForKey:capital] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifierSystem = @"cellReuseIdentifierSystem";
    static NSString *reuseIdentifierCustom = @"cellReuseIdentifierCustom";
    
    if (self.searchController.active) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierSystem];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifierSystem];
        }
        NSString *resultString = searchResultList[indexPath.row];
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:resultString];
        NSRange range = [resultString rangeOfString:searchWords];
        [attrString addAttribute:NSForegroundColorAttributeName value:kColor(orangeColor) range:range];
        cell.textLabel.attributedText = attrString;
        return cell;
    } else {
        if (indexPath.section >= 3) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierSystem];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifierSystem];
            }
            NSString *capital = initialsArray[indexPath.section - 3];
            CHCity *tmpCity = [formatCityDict objectForKey:capital][indexPath.row];
            cell.textLabel.text = tmpCity.cityName;
            return cell;
        }
        
        NSArray<NSString *> *array = nil;
        switch (indexPath.section) {
            case 0:
                array = @[@"深圳"];
                break;
                
            case 1:
                array = self.historyCitys;
                break;
                
            case 2:
                array = self.hotCitys;
                break;
        }
        
        CHCityListCell *cell = (CHCityListCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifierCustom];
        if (!cell) {
            cell = [[CHCityListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifierCustom];
        }
        [cell configCityListCellWithCityNames:array];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //  缓存行高，section=0/1/2 && row=0的行高
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *tmpKey = [NSString stringWithFormat:@"%ld", indexPath.section];
        NSNumber *tmpObj = [[NSNumber alloc] initWithFloat:cell.rowHeight];
        [userDefaults setObject:tmpObj forKey:tmpKey];
        [userDefaults synchronize];
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.searchController.active) {
        return 44;
    } else {
        if (indexPath.section >= 3) {
            return 44;
        }
        //  取出缓存的行高
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *tmpKey = [NSString stringWithFormat:@"%ld", indexPath.section];
        return [[userDefaults objectForKey:tmpKey] floatValue];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.searchController.active) {
        return nil;
    } else {
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
                title = initialsArray[section - 3];
                break;
        }
        CHCityListHeaderView *view = [CHCityListHeaderView headerView];
        [view configTitle:title];
        return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.searchController.active) {
        return 0;
    } else {
        return 25;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.searchController.active) {
        NSString *cityName = searchResultList[indexPath.row];
        [self selectedCityBy:cityName];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    } else {
        if (indexPath.section < 3) {
            return;
        }
        
        NSString *capital = initialsArray[indexPath.section - 3];
        CHCity *tmpCity = [formatCityDict objectForKey:capital][indexPath.row];
        
        [self selectedCityBy:tmpCity.cityName];
    }
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    searchWords = self.searchController.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchWords];
    
    searchResultList = [NSMutableArray arrayWithArray:[cityNames filteredArrayUsingPredicate:predicate]];
    NSMutableArray<NSString *> *searchResultPinyinList = [NSMutableArray arrayWithArray:[[self ignoreSubstringWithArray:cityPinyins] filteredArrayUsingPredicate:predicate]];
    
    for (int i = 0; i < specialCityPinyins.count; i++) {
        for (int j = 0; j < searchResultPinyinList.count; j++) {
            if ([specialCityPinyins[i] containsString:searchResultPinyinList[j]]) {
                searchResultPinyinList[j] = specialCityPinyins[i];
                break;
            }
        }
    }
    
    [self processPinyinSearchWithArray:searchResultPinyinList];
    [self.tableView reloadData];
}

#pragma mark - Pinyin Process
- (void)processPinyinSearchWithArray:(NSArray *)array {
    for (int i = 0; i < array.count; i++) {
        NSString *cityName = [cityMappingDict objectForKey:array[i]];
        if (![searchResultList containsObject:cityName]) {
            [searchResultList addObject:cityName];
        }
    }
}

#pragma mark - Ignore "-" Process
- (NSMutableArray *)ignoreSubstringWithArray:(NSMutableArray<NSString *> *)array {
    for (int i = 0; i < array.count; i++) {
        if ([array[i] containsString:@"_"]) {
            NSRange range = [array[i] rangeOfString:@"_"];
            NSUInteger location = range.location + 1;
            NSString *tmpString = [array[i] substringFromIndex:location];
            array[i] = tmpString;
        }
    }
    return array;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.indexView.hidden = YES;
    
    searchBar.showsCancelButton = YES;
    for (id obj in searchBar.subviews[0].subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)obj;
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn setTitleColor:kColor(orangeColor) forState:UIControlStateNormal];
        }
    }
    
    //  更新约束
    self.constraint.constant = 0.0f;
    [self.view setNeedsUpdateConstraints];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    self.indexView.hidden = NO;
    
    //  更新约束
    self.constraint.constant = -marginX;
    [self.view setNeedsUpdateConstraints];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"scrollView.contentOffset.y -> %lf", scrollView.contentOffset.y);
}

#pragma mark - Pressed - CityButton
- (void)cityButtonPressed:(UIButton *)btn {
    [self selectedCityBy:btn.titleLabel.text];
}

#pragma mark - Selected city
- (void)selectedCityBy:(NSString *)cityName {
    if (self.returnCityNameBlock) {
        self.returnCityNameBlock(cityName);
    }
    [self closeButtonPressed:nil];
}

#pragma mark - Block - Set
- (void)returnCityName:(ReturnCityNameBlock)block {
    self.returnCityNameBlock = block;
}

#pragma mark - CloseButtonPressed
- (void)closeButtonPressed:(UIButton *)btn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - NavigationButtonPressed
- (void)navigationButtonPressed:(CHButton *)btn {
    NSUInteger index = [indexArray indexOfObject:btn.titleLabel.text];
    if (index == 0) {
        [self.tableView setContentOffset:CGPointMake(0, -64)];
    } else {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index - 1];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
//        NSLog(@"contentOffset.y --> %lf", self.tableView.contentOffset.y);
    }
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = kColorCodeWithRGB(0xffd1a4);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = YES;
        self.tableView.tableHeaderView = _searchController.searchBar;
        self.tableView.tableFooterView = [[UIView alloc] init];
        _searchController.searchBar.placeholder = @"城市/行政区/拼音";
        _searchController.searchBar.delegate = self;
        [_searchController.searchBar sizeToFit];
    }
    return _searchController;
}

- (NSLayoutConstraint *)constraint {
    if (!_constraint) {
        _constraint = [[NSLayoutConstraint alloc] init];
    }
    return _constraint;
}

- (CHCityIndexView *)indexView {
    if (!_indexView) {
        indexArray = [NSMutableArray arrayWithArray:@[@"^", @"@", @"&", @"$"]];
        [indexArray addObjectsFromArray:initialsArray];
        _indexView = [CHCityIndexView indexViewWithButtonArray:indexArray];
        _indexView.backgroundColor = kColor(whiteColor);
    }
    return _indexView;
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

#pragma mark - ReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
