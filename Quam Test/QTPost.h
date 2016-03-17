//
//  QTPost.h
//  Quam Test
//
//  Created by ruckef on 16.03.16.
//  Copyright © 2016 ruckef. All rights reserved.
//

#import "QTObject.h"

@interface QTPost : QTObject
@property (nonatomic, readonly) NSString *byAvatar;
@property (nonatomic, readonly) NSString *byUserId;
@property (nonatomic, readonly) NSString *created;
@property (nonatomic, readonly) NSString *displayName;
@property (nonatomic, readonly) NSString *hashtags;
@property (nonatomic, readonly) NSString *image;
@property (nonatomic, readonly) NSString *mentionedUsers;
@property (nonatomic, readonly) NSString *postId;
@property (nonatomic, readonly) NSString *text;
@property (nonatomic, readonly) BOOL isLiked;
@property (nonatomic, readonly) BOOL isInDressList;
@property (nonatomic, readonly) BOOL isCommented;
@property (nonatomic, readonly) BOOL isNew;
@property (nonatomic, readonly) NSUInteger commentsCount;
@property (nonatomic, readonly) NSUInteger likesCount;
@end
