//
//  Address.m
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying Feng on 15/05/2016.
//  Copyright © 2016 Mengying FENG. All rights reserved.
//

#import "Address.h"

@implementation Address
-(id)initWithStreet:(NSString *)aStreet suburb:(NSString *)aSuburb state:(NSString *)aState country:(NSString *)aCountry {
    self = [super init];
    
    if (self != nil) {
        self.key = -1; // don't need to initialize, database automatically assgins it
        self.street = aStreet;
        self.suburb = aSuburb;
        self.state = aState;
        self.country = aCountry;
    }
    return self;
}
@end
