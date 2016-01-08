//
//  CHHomeViewController.m
//  CHCityPicker
//
//  Created by APP on 16/1/7.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import "CHHomeViewController.h"
#import "CHCityPickerViewController.h"

@interface CHHomeViewController ()
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, assign) BOOL      didSetupConstraints;
@end

@implementation CHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    CHCityPickerViewController *viewController = [[CHCityPickerViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
