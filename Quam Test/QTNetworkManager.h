//
//  QTNetworkManager.h
//  Quam Test
//
//  Created by ruckef on 16.03.16.
//  Copyright © 2016 ruckef. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QTSession.h"

typedef void(^QTLoginCompletion)(NSError *error, QTSession *session);

@interface QTNetworkManager : NSObject

@property (nonatomic, readonly) QTSession *session;

- (instancetype)initWithAppId:(NSString*)appId
                       apiKey:(NSString*)apiKey
                      appName:(NSString*)appName
                   appVersion:(NSString*)appVersion
                   deviceName:(NSString*)deviceName;

- (void)loginWithEmail:(NSString*)email
              password:(NSString*)password
            completion:(QTLoginCompletion)completion;

- (void)restoreSessionWithToken:(NSString*)token
                         userId:(NSString*)userId
                     completion:(QTLoginCompletion)completion;

@end
