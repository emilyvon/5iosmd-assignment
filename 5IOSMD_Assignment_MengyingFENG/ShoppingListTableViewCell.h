//
//  ShoppingListTableViewCell.h
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying Feng on 22/05/2016.
//  Copyright © 2016 Mengying FENG. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShoppingListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;


@end
