//
//  QTSettingsManager.h
//  Quam Test
//
//  Created by ruckef on 16.03.16.
//  Copyright © 2016 ruckef. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QTSettingsManager : NSObject

@property (nonatomic, readonly) BOOL isLastSessionTokenSaved;
@property (nonatomic, readonly) NSString *lastSessionToken;
@property (nonatomic, readonly) NSString *lastSessionUserId;

- (void)saveSessionToken:(NSString*)sessionToken
                  userId:(NSString*)userId;

@end
