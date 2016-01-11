//
//  CHCityListSystemCell.m
//  CHCityPicker
//
//  Created by APP on 16/1/11.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import "CHCityListSystemCell.h"

@implementation CHCityListSystemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.cityListCellType = CHCityListCellTypeSystem;
        self.rowHeight = 44.0f;
    }
    return self;
}

- (void)configCellTitle:(NSString *)title {
    self.textLabel.text = title;
}

@end
