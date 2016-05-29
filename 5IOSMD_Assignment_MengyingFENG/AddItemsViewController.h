//
//  AddItemsViewController.h
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying FENG on 13/04/2016.
//  Copyright (c) 2016 Mengying FENG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownPicker.h"
#include <sqlite3.h>
#import "AppDelegate.h"
#import "DataService.h"

@interface AddItemsViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController *imagePicker;
}
@property (weak, nonatomic) IBOutlet UITextField *productNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *productPriceTextField;
@property (weak, nonatomic) IBOutlet UITextField *productQuantityTextField;
@property (strong, nonatomic) DownPicker *downPicker;
- (IBAction)addButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
- (IBAction)pickImageButtonPressed:(id)sender;
- (IBAction)clearButtonPressed:(id)sender;
@end
