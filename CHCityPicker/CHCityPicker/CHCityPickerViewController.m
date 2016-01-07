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
    NSDictionary *cities;
    NSString *cityName;
}
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL didConstraint;
@end

@implementation CHCityPickerViewController

- (instancetype)init {
    if (self = [super init]) {
        cities = [self getInitDataWithFileName:@"cities" type:@"plist"];
    }
    return self;
}

- (NSDictionary *)getInitDataWithFileName:(NSString *)fileName type:(NSString *)type {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    return [NSDictionary dictionaryWithContentsOfFile:path];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%ld", cities.allKeys.count);
    self.view.backgroundColor = kColorF0F0F0;
    [self setupLayout];
}

- (void)setupLayout {
    [self.navigationController.navigationBar addSubview:self.closeButton];
    [self.navigationController.navigationBar addSubview:self.titleLabel];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
    if (!self.didConstraint) {
        //  closeButton
        [self.closeButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20 * kAutoScaleX];
        [self.closeButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        //  titleLabel
        [self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        self.didConstraint = YES;
    }
    [super updateViewConstraints];
}

#pragma mark  - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3 + cities.allKeys.count;            //  定位城市 + 最近访问城市 + 热门城市 +
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section <= 3) {
        return 1;
    }
    //  TODO:
    
    return 0;
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

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"请选择城市";
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
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
