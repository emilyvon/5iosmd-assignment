//
//  CustomUIView.m
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying Feng on 15/04/2016.
//  Copyright © 2016 Mengying FENG. All rights reserved.
//

#import "CustomUIView.h"

@implementation CustomUIView

-(void)awakeFromNib {
    self.layer.cornerRadius = 3.0;
    self.layer.shadowColor = [UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:0.5].CGColor;
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowRadius = 5.0;
    self.layer.shadowOffset = CGSizeMake(0.0, 2.0);

}

@end
