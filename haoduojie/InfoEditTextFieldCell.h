//
//  InfoEditTextFieldCell.h
//  haoduojie
//
//  Created by  on 12-4-5.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoEditTextFieldCell : UITableViewCell {
    UILabel *label;
    UITextField *input;
}
@property (retain, nonatomic) IBOutlet UILabel *label;
@property (retain, nonatomic) IBOutlet UITextField *input;

@end
