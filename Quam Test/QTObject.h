//
//  QTObject.h
//  Quam Test
//
//  Created by ruckef on 16.03.16.
//  Copyright © 2016 ruckef. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol QTDeserializable <NSObject>
- (instancetype)initWithDic:(NSDictionary *)dic;
- (void)deserialize:(NSDictionary*)dic;
@end


@interface QTObject : NSObject <QTDeserializable>

@end
