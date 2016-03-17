//
//  QTUser.h
//  Quam Test
//
//  Created by ruckef on 16.03.16.
//  Copyright © 2016 ruckef. All rights reserved.
//

#import "QTObject.h"
#import "QTPost.h"

@interface QTUser : QTObject
@property (nonatomic, readonly) NSString *userId;
@property (nonatomic, readonly) NSString *avatarUrl;
@property (nonatomic, readonly) NSString *displayName;
@property (nonatomic, readonly) NSString *email;
@property (nonatomic, readonly) NSString *nickName;
@property (nonatomic, readonly) NSUInteger followersCount;
@property (nonatomic, readonly) NSUInteger followingCount;
@property (nonatomic, readonly) BOOL isFollowing;
@property (nonatomic, readonly) BOOL isShop;
@property (nonatomic, readonly) NSUInteger postsCount;
@property (nonatomic, readonly) NSUInteger dressCount;
@property (nonatomic, readonly) NSArray *posts;
@end
