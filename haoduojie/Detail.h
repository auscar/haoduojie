//
//  Detail.h
//  haoduojie
//
//  Created by  on 12-4-3.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Detail : UITableViewCell {
    
    UIImageView *detailImage;
    UITextView *detailText;
}
@property (retain, nonatomic) IBOutlet UITextView *detailText;
@property (retain, nonatomic) IBOutlet UIImageView *detailImage;
@end
