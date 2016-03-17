//
//  QTUserInfoHeader.h
//  Quam Test
//
//  Created by ruckef on 17.03.16.
//  Copyright © 2016 ruckef. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTUser.h"

@interface QTUserInfoHeader : UIView
@property (nonatomic, strong) QTUser *user;
- (void)setup;
@end
