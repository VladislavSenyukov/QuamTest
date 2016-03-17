//
//  QTObject.m
//  Quam Test
//
//  Created by ruckef on 16.03.16.
//  Copyright © 2016 ruckef. All rights reserved.
//

#import "QTObject.h"

@implementation QTObject

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self deserialize:dic];
    }
    return self;
}

- (void)deserialize:(NSDictionary *)dic {
    
}

@end
