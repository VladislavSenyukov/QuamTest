//
//  QTFacade.m
//  Quam Test
//
//  Created by ruckef on 16.03.16.
//  Copyright © 2016 ruckef. All rights reserved.
//

#import "QTFacade.h"
#import "QTSettingsManager.h"
#import "QTNetworkManager.h"
#import <UIKit/UIKit.h>

@interface QTFacade ()
@property (nonatomic, strong) QTNetworkManager *network;
@property (nonatomic, strong) QTSettingsManager *settings;
@end

@implementation QTFacade

+ (instancetype)instance {
    static dispatch_once_t onceToken;
    static QTFacade *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[QTFacade alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.settings = [[QTSettingsManager alloc] init];
        NSString *deviceName = [[UIDevice currentDevice] model];
        self.network = [[QTNetworkManager alloc] initWithAppId:kAppId apiKey:kAPIKey appName:kAppName appVersion:kAppVersion deviceName:deviceName];
    }
    return self;
}

#pragma mark - Interface

- (void)loginWithEmail:(NSString *)email
              password:(NSString *)password
            completion:(QTErrorCompletion)completion {
    [self.network loginWithEmail:email password:password completion:^(NSError *error, QTSession *session) {
        // TODO: save settings
        if (completion) {
            completion(error);
        }
    }];
}

- (BOOL)canRestoreSession {
    return self.settings.isLastSessionTokenSaved;
}

- (void)restoreSession:(QTErrorCompletion)completion {
    NSString *token = self.settings.lastSessionToken;
    NSString *userId = self.settings.lastSessionUserId;
    [self.network restoreSessionWithToken:token userId:userId completion:^(NSError *error, QTSession *session) {
        if (completion) {
            completion(error);
        }
    }];
}

- (QTUser *)user {
    return self.network.session.user;
}

@end
