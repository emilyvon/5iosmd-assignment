//
//  ShoppingListTableViewCell.m
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying Feng on 22/05/2016.
//  Copyright © 2016 Mengying FENG. All rights reserved.
//

#import "ShoppingListTableViewCell.h"


@implementation ShoppingListTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialiation code
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _categoryLabel.layer.cornerRadius = 4.0;
    _categoryLabel.layer.masksToBounds = YES;
    _img.layer.cornerRadius = _img.frame.size.width / 2;
    _img.clipsToBounds = YES;
    _img.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


@end
