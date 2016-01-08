//
//  CHCityPickerViewController.m
//  CHCityPicker
//
//  Created by APP on 16/1/7.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import "CHCityPickerViewController.h"

@interface CHCityPickerViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *citys;
    NSString *cityName;
}
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL didConstraint;
@end

@implementation CHCityPickerViewController

- (instancetype)init {
    if (self = [super init]) {
        citys = [self analysisJSONDataWithString:[self stringWithFileName:@"cityList" type:@"json"]];
    }
    return self;
}

/**
 *  根据JSON文件名，返回文件内容
 *
 *  @param fileName 文件名
 *  @param type     文件扩展名，@"json"
 *
 *  @return 文件内容
 */
- (NSString *)stringWithFileName:(NSString *)fileName type:(NSString *)type {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    NSError *error = nil;
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
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
    NSLog(@"%ld", citys.count);
    self.view.backgroundColor = kColorF0F0F0;
    self.navigationItem.title = @"请选择城市";
    [self setupLayout];
}

- (void)setupLayout {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.closeButton];
    
//    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
    if (!self.didConstraint) {
        
        self.didConstraint = YES;
    }
    [super updateViewConstraints];
}

#pragma mark  - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3 + citys.count;            //  定位城市 + 最近访问城市 + 热门城市 +
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section <= 3) {
        return 1;
    }
    //  TODO:
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //  TODO:
    return [[UITableViewCell alloc] init];
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
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
