//
//  QTRoundedImageView.m
//  Quam Test
//
//  Created by ruckef on 17.03.16.
//  Copyright © 2016 ruckef. All rights reserved.
//

#import "QTRoundedImageView.h"

@implementation QTRoundedImageView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.clipsToBounds = YES;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat cornerRadius = self.frame.size.width/2.0;
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = 2.5;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
}

@end
