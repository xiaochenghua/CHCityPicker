//
//  CHCityPickerController.h
//  CHCityPicker
//
//  Created by arnoldxiao on 16/1/13.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnCityNameBlock)(NSString *title);

@interface CHCityPickerController : UIViewController

- (void)returnCityName:(ReturnCityNameBlock)block;

@end
