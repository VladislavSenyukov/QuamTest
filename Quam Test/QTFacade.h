//
//  QTFacade.h
//  Quam Test
//
//  Created by ruckef on 16.03.16.
//  Copyright © 2016 ruckef. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QTDefinitions.h"
#import "QTUser.h"

#define QTFacadeShared ([QTFacade instance])

@interface QTFacade : NSObject
+ (instancetype)instance;
- (void)loginWithEmail:(NSString*)email
              password:(NSString*)password
            completion:(QTErrorCompletion)completion;
- (void)restoreSession:(QTErrorCompletion)completion;
@property (nonatomic, readonly) BOOL canRestoreSession;
@property (nonatomic, readonly) QTUser *user;
@end
