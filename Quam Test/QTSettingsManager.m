//
//  QTSettingsManager.m
//  Quam Test
//
//  Created by ruckef on 16.03.16.
//  Copyright © 2016 ruckef. All rights reserved.
//

#import "QTSettingsManager.h"
#import "QTDefinitions.h"

@implementation QTSettingsManager

- (instancetype)init {
    if (self = [super init]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        _lastSessionToken = [defaults stringForKey:kQTSMSessionTokenKey];
        _lastSessionUserId = [defaults stringForKey:kQTSMUserIdKey];
    }
    return self;
}

- (BOOL)isLastSessionTokenSaved {
    BOOL isSaved = _lastSessionToken && _lastSessionUserId;
    return isSaved;
}

- (void)saveSessionToken:(NSString *)sessionToken
                  userId:(NSString *)userId {
    _lastSessionToken = sessionToken;
    _lastSessionUserId = userId;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:sessionToken forKey:kQTSMSessionTokenKey];
    [defaults setObject:userId forKey:kQTSMUserIdKey];
    [defaults synchronize];
}

@end
