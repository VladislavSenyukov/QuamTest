//
//  QTCollectionViewParallaxLayout.m
//  Quam Test
//
//  Created by ruckef on 17.03.16.
//  Copyright © 2016 ruckef. All rights reserved.
//

#import "QTCollectionViewParallaxLayout.h"

@implementation QTCollectionViewParallaxLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    UICollectionView *collectionView = [self collectionView];
    UIEdgeInsets insets = [collectionView contentInset];
    CGPoint offset = [collectionView contentOffset];
    CGFloat minY = -insets.top;
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    if (offset.y < minY) {
        return attributes;
    }
    
    for (UICollectionViewLayoutAttributes *attr in attributes) {
        NSString *kind = attr.representedElementKind;
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            CGRect frame = attr.frame;
            if (attr.indexPath.section == 1) {
                frame.size.height = 80;
                attr.zIndex = 1;
            } else {
                CGFloat deltaY = ABS(offset.y - minY);
                CGFloat offset = deltaY/3.0;
                frame.origin.y = offset;
                attr.zIndex = 0;
            }
            attr.frame = frame;
        } else {
            attr.zIndex = 1024;
        }
    }
    return attributes;
}

@end
