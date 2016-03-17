//
//  QTSession.h
//  Quam Test
//
//  Created by ruckef on 16.03.16.
//  Copyright © 2016 ruckef. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QTUser.h"

@interface QTSession : NSObject
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) QTUser *user;
@end
