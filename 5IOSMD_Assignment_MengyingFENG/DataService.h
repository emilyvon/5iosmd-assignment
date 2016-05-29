//
//  DataService.h
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying Feng on 14/05/2016.
//  Copyright © 2016 Mengying FENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataService : NSObject
{
    NSArray *categories;
}
+ (DataService *)sharedService;

-(NSArray *)getCategories;

@end
