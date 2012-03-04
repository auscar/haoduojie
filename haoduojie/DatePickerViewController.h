//
//  DatePickerViewController.h
//  haoduojie
//
//  Created by  on 12-3-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerViewController : UIViewController
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
-(IBAction)buttonPressed;

@end
