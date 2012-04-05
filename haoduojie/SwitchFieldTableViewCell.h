//
//  SwitchFieldTableViewCell.h
//  haoduojie
//
//  Created by  on 12-4-5.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchFieldTableViewCell : UITableViewCell {
    UILabel *label;
    UISwitch *switchBtn;
    
}

@property (retain, nonatomic) IBOutlet UILabel *label;
@property (retain, nonatomic) IBOutlet UISwitch *switchBtn;


@end
