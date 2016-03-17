//
//  QTCollectionViewCell.h
//  Quam Test
//
//  Created by ruckef on 16.03.16.
//  Copyright © 2016 ruckef. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTPost.h"

@interface QTCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) QTPost *post;
@end
