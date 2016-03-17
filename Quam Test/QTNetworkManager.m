//
//  QTNetworkManager.m
//  Quam Test
//
//  Created by ruckef on 16.03.16.
//  Copyright © 2016 ruckef. All rights reserved.
//

#import "QTNetworkManager.h"
#import "AFNetworking.h"
#import "QTDefinitions.h"

@interface QTNetworkManager ()
@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) NSString *appVersion;
@property (nonatomic, strong) NSString *deviceName;
@property (nonatomic, strong) AFHTTPSessionManager *httpSessionManager;
@end

@implementation QTNetworkManager
- (instancetype)initWithAppId:(NSString *)appId
                       apiKey:(NSString *)apiKey
                      appName:(NSString *)appName
                   appVersion:(NSString *)appVersion
                   deviceName:(NSString *)deviceName {
    if (self = [super init]) {
        self.appId = appId;
        self.apiKey = apiKey;
        self.appName = appName;
        self.appVersion = appVersion;
        self.deviceName = deviceName;
        _session = [[QTSession alloc] init];
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSDictionary *headers = @{@"X-Parse-Application-Id" : appId, @"X-Parse-REST-API-Key" : apiKey};
        configuration.HTTPAdditionalHeaders = headers;
        NSURL *baseUrl = [NSURL URLWithString:kBaseUrl];
        self.httpSessionManager = [[AFHTTPSessionManager manager] initWithBaseURL:baseUrl sessionConfiguration:configuration];
        self.httpSessionManager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    return self;
}

- (void)loginWithEmail:(NSString *)email
              password:(NSString *)password
            completion:(QTLoginCompletion)completion {
    NSAssert(email, @"No email");
    NSAssert(password, @"No pwd");
    NSString *function = @"login";
    NSDictionary *parameters = @{@"app_name"    : self.appName,
                                 @"app_version" : self.appVersion,
                                 @"device_info" : self.deviceName,
                                 @"email"       : email,
                                 @"password"    : password};
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    __weak typeof(self) weakSelf = self;
    [self.httpSessionManager POST:function
                       parameters:parameters
                         progress:nil
                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = responseObject[@"result"];
        NSString *token = result[@"sessionToken"];
        NSDictionary *userDic = result[@"user"];
        weakSelf.session.token = token;
        weakSelf.session.user = [[QTUser alloc] initWithDic:userDic];
        if (completion) {
            completion(nil, weakSelf.session);
        }
        dispatch_semaphore_signal(sema);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        weakSelf.session.token = nil;
        weakSelf.session.user = nil;
        if (completion) {
            completion(error, nil);
        }
        dispatch_semaphore_signal(sema);
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

- (void)restoreSessionWithToken:(NSString *)token
                         userId:(NSString *)userId
                     completion:(QTLoginCompletion)completion {
    
}

@end
