//
//  CustomImageView.m
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying Feng on 13/04/2016.
//  Copyright © 2016 Mengying FENG. All rights reserved.
//

#import "CustomImageView.h"

@implementation CustomImageView

-(void)awakeFromNib {
    self.layer.cornerRadius = self.layer.frame.size.width / 2;
    self.clipsToBounds = YES;
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
}

@end
