//
//  QTUserInfoHeader.m
//  Quam Test
//
//  Created by ruckef on 17.03.16.
//  Copyright © 2016 ruckef. All rights reserved.
//

#import "QTUserInfoHeader.h"
#import "QTRoundedImageView.h"
#import "UIImageView+WebCache.h"

@interface QTUserInfoHeader ()
@property (nonatomic, strong) QTRoundedImageView *avatarImage;
@property (nonatomic, strong) UILabel *userNameLabel;
@end

@implementation QTUserInfoHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.avatarImage];
        [self addSubview:self.userNameLabel];
    }
    return self;
}

- (void)setup {
    NSDictionary *views = @{@"avatarImage" : self.avatarImage, @"name" : self.userNameLabel};
    NSArray *strings = @[@"V:|-40-[avatarImage]", @"[avatarImage]", @"V:[avatarImage]-20-[name(20)]", @"|-0-[name]-0-|"];
    for (NSString *constraintStr in strings) {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:constraintStr options:0 metrics:nil views:views]];
    }
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarImage attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.5 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.avatarImage attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
}

#pragma mark - Getters/Setter

- (QTRoundedImageView *)avatarImage {
    if (!_avatarImage) {
        _avatarImage = [[QTRoundedImageView alloc] init];
        _avatarImage.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _avatarImage;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _userNameLabel.textAlignment = NSTextAlignmentCenter;
        _userNameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
        _userNameLabel.textColor = [UIColor whiteColor];
    }
    return _userNameLabel;
}

- (void)setUser:(QTUser *)user {
    _user = user;
    [self updateUI];
}

- (void)updateUI {
    NSString *avatarUrl = self.user.avatarUrl;
    [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:avatarUrl]];
    self.userNameLabel.text = self.user.displayName;
}

@end
