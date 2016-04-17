//
//  CancelButton.m
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying Feng on 14/04/2016.
//  Copyright © 2016 Mengying FENG. All rights reserved.
//

#import "CancelButton.h"

@implementation CancelButton

-(void)awakeFromNib {
    self.layer.cornerRadius = 3.0;
    self.layer.backgroundColor = [UIColor colorWithRed:172.0/255.0 green:164.0/255.0 blue:162.0/255.0 alpha:1.0].CGColor;
    self.titleLabel.font = [UIFont fontWithName:@"Quicksand-Regular" size:18];

    self.layer.shadowColor = [UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:0.5].CGColor;
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowRadius = 5.0;
    self.layer.shadowOffset = CGSizeMake(0.0, 2.0);
}

@end
