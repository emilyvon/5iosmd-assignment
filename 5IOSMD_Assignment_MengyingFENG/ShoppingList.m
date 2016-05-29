//
//  ShoppingList.m
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying Feng on 14/05/2016.
//  Copyright © 2016 Mengying FENG. All rights reserved.
//

#import "ShoppingList.h"

@implementation ShoppingList
-(id)initWithItem:(NSString *)newItem price:(double)newPrice quantity:(int)newQuantity groupid:(int)newGroupid imageUrl:(NSString *)newUrl {
    self = [super init];
    
    if (self != nil) {
        self.key = -1; // don't need to initialize, database automatically assgins it
        self.item = newItem;
        self.price = newPrice;
        self.quantity = newQuantity;
        self.groupid = newGroupid;
        self.imageUrl = newUrl;
    }
    return self;
}
@end
