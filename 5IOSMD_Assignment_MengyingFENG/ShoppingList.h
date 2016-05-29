//
//  ShoppingList.h
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying Feng on 14/05/2016.
//  Copyright © 2016 Mengying FENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingList : NSObject

@property int key;
@property NSString *item;
@property double price;
@property int quantity;
@property int groupid;
@property NSString *imageUrl;

-(id)initWithItem: (NSString *)newItem price: (double) newPrice quantity: (int) newQuantity groupid: (int) newGroupid imageUrl: (NSString *)newUrl;
@end
