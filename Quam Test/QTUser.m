//
//  QTUser.m
//  Quam Test
//
//  Created by ruckef on 16.03.16.
//  Copyright © 2016 ruckef. All rights reserved.
//

#import "QTUser.h"

@implementation QTUser

- (void)deserialize:(NSDictionary *)dic {
    _userId = dic[@"user_id"];
    NSString *avatarUrl = dic[@"avatar"];
    _avatarUrl = [avatarUrl stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"];
    _displayName = dic[@"display_name"];
    _dressCount = [dic[@"dress_count"] unsignedIntegerValue];
    _email = dic[@"email"];
    _followersCount = [dic[@"followers_counter"] unsignedIntegerValue];
    _followingCount = [dic[@"following_counter"] unsignedIntegerValue];
    _isFollowing = [dic[@"is_following"] boolValue];
    _isShop = [dic[@"is_shop"] boolValue];
    _nickName = dic[@"nickname"];
    _postsCount = [dic[@"posts_count"] unsignedIntegerValue];
    NSArray *postsDics = dic[@"posts"];
    NSMutableArray *posts = [[NSMutableArray alloc] init];
    for (NSDictionary *postDic in postsDics) {
        QTPost *post = [[QTPost alloc] initWithDic:postDic];
        [posts addObject:post];
    }
    _posts = [NSArray arrayWithArray:posts];
}

@end
