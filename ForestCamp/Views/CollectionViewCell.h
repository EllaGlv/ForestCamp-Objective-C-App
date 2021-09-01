//
//  CollectionViewCell.h
//  ForestCamp
//
//  Created by Alla Golovinova on 7/22/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *categoryImages;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfItemsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *checkedCategoryIcon;

@end

NS_ASSUME_NONNULL_END
