//
//  CHHomeViewController.m
//  CHCityPicker
//
//  Created by APP on 16/1/7.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import "CHHomeViewController.h"
#import "CHCityPickerController.h"

@interface CHHomeViewController ()
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, assign) BOOL     didSetupConstraints;
@end

@implementation CHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSelectButton];
}

- (void)setupSelectButton {
    [self.view addSubview:self.selectButton];
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {
        [self.selectButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.selectButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:200];
        [self.selectButton autoSetDimensionsToSize:CGSizeMake(200, 45)];
        
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

#pragma mark - 懒加载
- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [[UIButton alloc] init];
        _selectButton.backgroundColor = kColor(orangeColor);
        [_selectButton setTitleColor:kColor(whiteColor) forState:UIControlStateNormal];
        [_selectButton setTitle:@"请选择城市" forState:UIControlStateNormal];
        _selectButton.layer.cornerRadius = 5.0f;
        _selectButton.layer.masksToBounds = YES;
        [_selectButton addTarget:self action:@selector(selectButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

- (void)selectButtonPressed:(UIButton *)btn {
    CHCityPickerController *viewController = [[CHCityPickerController alloc] init];
    [viewController returnCityName:^(NSString *title) {
        [_selectButton setTitle:title forState:UIControlStateNormal];
    }];
    viewController.navigationItem.title = [self.selectButton.titleLabel.text isEqualToString:@"请选择城市"] ? self.selectButton.titleLabel.text : [NSString stringWithFormat:@"当前城市-%@", self.selectButton.titleLabel.text];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
