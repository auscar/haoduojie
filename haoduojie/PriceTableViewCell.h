//
//  PriceTableViewCell.h
//  haoduojie
//
//  Created by  on 12-4-8.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceTableViewCell : UITableViewCell {
    UILabel *label;
    UITextField *price;
    UISwitch *priceSwitchBtn;
    UIPickerView *priceTypePicker;
}

@property (retain, nonatomic) IBOutlet UILabel *label;
@property (retain, nonatomic) IBOutlet UITextField *price;
@property (retain, nonatomic) IBOutlet UISwitch *priceSwitchBtn;
@property (retain, nonatomic) IBOutlet UIPickerView *priceTypePicker;

@end
