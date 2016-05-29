//
//  DataService.m
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying Feng on 14/05/2016.
//  Copyright © 2016 Mengying FENG. All rights reserved.
//

#import "DataService.h"


@implementation DataService

static DataService *sharedDataService = nil;

+ (DataService *)sharedService {
    if (sharedDataService == nil) {
        sharedDataService = [[super allocWithZone:NULL]init];
    }
    return sharedDataService;
}

-(NSArray *)getCategories {
    return @[@"Default", @"Groceries", @"Electronic", @"Clothing", @"Home", @"Cosmetics", @"Health", @"Pet"];
}

@end
