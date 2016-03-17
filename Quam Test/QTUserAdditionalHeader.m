//
//  QTUserAdditionalHeader.m
//  Quam Test
//
//  Created by ruckef on 17.03.16.
//  Copyright © 2016 ruckef. All rights reserved.
//

#import "QTUserAdditionalHeader.h"

@interface QTUserAdditionalHeader ()
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation QTUserAdditionalHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.textLabel];
    }
    return self;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:25];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.text = @"Quam Test";
    }
    return _textLabel;
}

- (void)setup {
    NSDictionary *views = @{@"text" : self.textLabel};
    NSArray *strings = @[@"V:|-0-[text]-0-|", @"|-0-[text]-0-|"];
    for (NSString *constraintStr in strings) {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:constraintStr options:0 metrics:nil views:views]];
    }
}

@end
