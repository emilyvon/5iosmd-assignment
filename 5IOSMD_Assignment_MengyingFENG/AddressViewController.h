//
//  AddressViewController.h
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying FENG on 13/04/2016.
//  Copyright (c) 2016 Mengying FENG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddAddressViewController.h"

@interface AddressViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, AddAddressViewControllerDelegate>
{
    NSMutableArray *addressListArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
