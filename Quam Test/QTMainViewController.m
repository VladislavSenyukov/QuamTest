//
//  QTMainViewController.m
//  Quam Test
//
//  Created by ruckef on 16.03.16.
//  Copyright © 2016 ruckef. All rights reserved.
//

#import "QTMainViewController.h"
#import "QTFacade.h"
#import "QTCollectionViewCell.h"
#import "QTParallaxHeader.h"
#import "QTCollectionViewParallaxLayout.h"

#define kItemsPerRow        2
#define kHeaderHeightRate   2.4
#define kParallaxHeaderIdentifier   @"kParallaxHeaderIdentifier"
#define kHeaderIdentifier           @"kHeaderIdentifier"

@interface QTMainViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet QTCollectionViewParallaxLayout *headerFlowLayout;
@property (nonatomic, strong) QTUser *user;
@end

@implementation QTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.user = QTFacadeShared.user;
    UINib *headerNib = [UINib nibWithNibName:@"QTParallaxHeader" bundle:nil];
    [self.collectionView registerNib:headerNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kParallaxHeaderIdentifier];
    headerNib = [UINib nibWithNibName:@"QTCategoriesStillHeader" bundle:nil];
    [self.collectionView registerNib:headerNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderIdentifier];
}

#pragma mark - Collection View Delegates

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    if (section == 1) {
        NSUInteger postsCount = self.user.posts.count;
        return postsCount;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = @"postCell";
    QTCollectionViewCell *cell = (QTCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSUInteger section = indexPath.section - 1;
    NSUInteger index = kItemsPerRow * section + indexPath.row;
    QTPost *post = self.user.posts[index];
    cell.post = post;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        CGFloat width = self.view.frame.size.width;
        CGFloat height = self.view.frame.size.height;
        return CGSizeMake(width, height/kHeaderHeightRate);
    }
    return CGSizeMake(self.view.frame.size.width, 80);
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    QTCollectionViewParallaxLayout *layout = self.headerFlowLayout;
    NSUInteger itemsPerRow = kItemsPerRow;
    CGFloat additionalSpace = layout.minimumInteritemSpacing * (itemsPerRow-1) * 2 + layout.sectionInset.left + layout.sectionInset.right;
    CGFloat width = self.view.frame.size.width;
    CGFloat itemWidth = (width - additionalSpace)/itemsPerRow;
    CGSize size = CGSizeMake(itemWidth, itemWidth/2*3);
    return size;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = indexPath.section ? kHeaderIdentifier : kParallaxHeaderIdentifier;
    UICollectionReusableView *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if ([cell isKindOfClass:[QTParallaxHeader class]]) {
        QTParallaxHeader *header = (QTParallaxHeader*)cell;
        [header setUser:self.user];
    }
    return cell;
}

@end
