//
//  QTParallaxHeader.m
//  Quam Test
//
//  Created by ruckef on 17.03.16.
//  Copyright © 2016 ruckef. All rights reserved.
//

#import "QTParallaxHeader.h"
#import "UIImageView+WebCache.h"
#import "QTUserInfoHeader.h"
#import "QTUserAdditionalHeader.h"

@interface QTParallaxHeader () <UIScrollViewDelegate>
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentScrollView;
@property (nonatomic) BOOL isScrollSetUp;
@property (nonatomic, strong) QTUserInfoHeader *infoHeader;
@property (nonatomic, strong) QTUserAdditionalHeader *additionalHeader;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation QTParallaxHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupPagingContent];
}

- (void)setupPagingContent {
    if (!self.isScrollSetUp) {
        self.isScrollSetUp = YES;
        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectZero];
        scroll.delegate = self;
        scroll.pagingEnabled = YES;
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:scroll];
        NSDictionary *views = @{@"scroll" : scroll};
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[scroll]" options:0 metrics:nil views:views]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:scroll attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:scroll attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:scroll attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
        self.scrollView = scroll;
        
        [self.contentView addSubview:self.pageControl];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.pageControl attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        
        
        UIView *contentView = self.contentScrollView;
        [scroll addSubview:contentView];
        [self updateContentSize];

        void (^addConstraintsToView)(UIView *view, NSArray *strings, NSDictionary *viewsDic);
        addConstraintsToView = ^(UIView *view, NSArray *strings, NSDictionary *viewsDic) {
            for (NSString *constraintStr in strings) {
                [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:constraintStr options:0 metrics:nil views:viewsDic]];
            }
        };
        
        [contentView addSubview:self.infoHeader];
        NSDictionary *viewsDic = @{@"info" : self.infoHeader};
        NSArray *constraints = @[@"|-0-[info]", @"V:|-0-[info]-0-|"];
        addConstraintsToView(contentView, constraints, viewsDic);
        [scroll addConstraint:[NSLayoutConstraint constraintWithItem:self.infoHeader attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:scroll attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
        [self.infoHeader setup];
        
        [self.contentView insertSubview:self.additionalHeader belowSubview:scroll];
        viewsDic = @{@"add_info" : self.additionalHeader};
        constraints = @[@"|-0-[add_info]-0-|", @"V:|-0-[add_info]-0-|"];
        addConstraintsToView(self.contentView, constraints, viewsDic);
        [self.additionalHeader setup];
    }
}

- (void)updateContentSize {
    CGRect contentRect = self.contentView.bounds;
    contentRect.size.width *= 2;
    self.contentScrollView.frame = contentRect;
    self.scrollView.contentSize = contentRect.size;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateContentSize];
    CGFloat offset = self.scrollView.contentOffset.x;
    [self.additionalHeader updateLabelWithScrollOffset:offset];
}

- (void)updateUI {
    NSString *urlString = self.user.avatarUrl;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
}

- (void)pageControlChanged:(UIPageControl*)sender {
    CGFloat width = self.scrollView.frame.size.width;
    CGPoint currentContentOffset = self.scrollView.contentOffset;
    currentContentOffset.x = sender.currentPage * width;
    [self.scrollView setContentOffset:currentContentOffset animated:YES];
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat width = scrollView.frame.size.width;
    CGFloat offset = scrollView.contentOffset.x;
    self.pageControl.currentPage = (NSUInteger)(offset/width);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x;
    [self.additionalHeader updateLabelWithScrollOffset:offset];
}

#pragma mark - Getters/Setters

- (void)setUser:(QTUser *)user {
    _user = user;
    self.infoHeader.user = user;
    [self updateUI];
}

- (QTUserInfoHeader *)infoHeader {
    if (!_infoHeader) {
        _infoHeader = [[QTUserInfoHeader alloc] init];
        _infoHeader.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _infoHeader;
}

- (QTUserAdditionalHeader *)additionalHeader {
    if (!_additionalHeader) {
        _additionalHeader = [[QTUserAdditionalHeader alloc] init];
        _additionalHeader.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _additionalHeader;
}

- (UIView *)contentScrollView {
    if (!_contentScrollView) {
        _contentScrollView = [[UIView alloc] init];
    }
    return _contentScrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.translatesAutoresizingMaskIntoConstraints = NO;
        _pageControl.numberOfPages = 2;
        [_pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}

@end
