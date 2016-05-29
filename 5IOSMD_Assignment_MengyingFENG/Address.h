//
//  Address.h
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying Feng on 15/05/2016.
//  Copyright © 2016 Mengying FENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Address : NSObject
@property int key;
@property NSString *street;
@property NSString *suburb;
@property NSString *state;
@property NSString *country;
-(id)initWithStreet: (NSString *)aStreet suburb: (NSString *)aSuburb state: (NSString *)aState country: (NSString *)aCountry;
@end
