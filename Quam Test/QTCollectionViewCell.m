//
//  QTCollectionViewCell.m
//  Quam Test
//
//  Created by ruckef on 16.03.16.
//  Copyright © 2016 ruckef. All rights reserved.
//

#import "QTCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "QTRoundedImageView.h"

@interface QTCollectionViewCell ()
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet QTRoundedImageView *avatarImageView;
@property (nonatomic, weak) IBOutlet UILabel *likesLabel;
@property (nonatomic, weak) IBOutlet UILabel *commentsLabel;
@end

@implementation QTCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setPost:(QTPost *)post {
    _post = post;
    [self updateUI];
}

- (void)updateUI {
    QTPost *post = self.post;
    NSString *bgImageUrl = post.image;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:bgImageUrl]];
    
    NSString *avatarUrl = post.byAvatar;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:avatarUrl]];
    
    self.likesLabel.text = [NSString stringWithFormat:@"%lu", post.likesCount];
    self.commentsLabel.text = [NSString stringWithFormat:@"%lu", post.commentsCount];
}

@end
