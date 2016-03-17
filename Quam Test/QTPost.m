//
//  QTPost.m
//  Quam Test
//
//  Created by ruckef on 16.03.16.
//  Copyright © 2016 ruckef. All rights reserved.
//

#import "QTPost.h"

@implementation QTPost

- (void)deserialize:(NSDictionary *)dic {
    NSString *avatarUrl = dic[@"by_avatar"];
    _byAvatar = [avatarUrl stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"];
    _byUserId = dic[@"by_user_id"];
    _commentsCount = [dic[@"comments_count"] unsignedIntegerValue];
    _created = dic[@"created"];
    _displayName = dic[@"display_name"];
    _hashtags = dic[@"hashtags"];
    NSString *imageUrl = dic[@"image"];
    _image = [imageUrl stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"];
    _isNew = [dic[@"isNew"] boolValue];
    _isCommented = [dic[@"is_commented"] boolValue];
    _isInDressList = [dic[@"is_in_dress_list"] boolValue];
    _isLiked = [dic[@"is_liked"] boolValue];
    _likesCount = [dic[@"likes_count"] unsignedIntegerValue];
    _mentionedUsers = dic[@"mentioned_users"];
    _postId = dic[@"post_id"];
    _text = dic[@"text"];
}

@end
