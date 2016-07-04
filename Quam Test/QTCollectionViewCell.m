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
#import "SDWebImageManager.h"

@interface QTCollectionViewCell ()
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet QTRoundedImageView *avatarImageView;
@property (nonatomic, weak) IBOutlet UILabel *likesLabel;
@property (nonatomic, weak) IBOutlet UILabel *commentsLabel;
@end

@implementation QTCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)setPost:(QTPost *)post {
    _post = post;
    [self updateUI];
}

- (void)updateUI {
    QTPost *post = self.post;
    NSURL *bgImageUrl = [NSURL URLWithString:post.image];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[SDWebImageManager sharedManager] downloadImageWithURL:bgImageUrl options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.imageView.image = image;
                });
            }
        }];
    });
    
    NSURL *avatarUrl = [NSURL URLWithString:self.post.byAvatar];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[SDWebImageManager sharedManager] downloadImageWithURL:avatarUrl options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.avatarImageView.image = image;
                });
            }
        }];
    });
    
    self.likesLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)post.likesCount];
    self.commentsLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)post.commentsCount];
}

@end
