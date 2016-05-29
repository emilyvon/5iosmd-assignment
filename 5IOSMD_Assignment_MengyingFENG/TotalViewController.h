//
//  TotalViewController.h
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying FENG on 13/04/2016.
//  Copyright (c) 2016 Mengying FENG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingList.h"
#include <sqlite3.h>
#import "AppDelegate.h"
#import "DataService.h"

@interface TotalViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *shoppingListArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;

@end
