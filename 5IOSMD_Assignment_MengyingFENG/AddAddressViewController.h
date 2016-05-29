//
//  AddAddressViewController.h
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying Feng on 17/04/2016.
//  Copyright © 2016 Mengying FENG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Address.h"
#include <sqlite3.h>
#import "AppDelegate.h"


@class AddAddressViewController;

@protocol AddAddressViewControllerDelegate <NSObject>

-(void)addAddressViewControllerDismissed:(AddAddressViewController *)controller withAddress: (Address *)address;
@end

@interface AddAddressViewController : UIViewController

@property (weak, nonatomic) id<AddAddressViewControllerDelegate> myDelegate;
@property (weak, nonatomic) IBOutlet UITextField *streetTextField;
@property (weak, nonatomic) IBOutlet UITextField *suburbTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UITextField *countryTextField;

- (IBAction)addButtonPressed:(id)sender;

@end
