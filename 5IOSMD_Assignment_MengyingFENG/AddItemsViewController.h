//
//  AddItemsViewController.h
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying FENG on 13/04/2016.
//  Copyright (c) 2016 Mengying FENG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownPicker.h"

@interface AddItemsViewController : UIViewController <UITextFieldDelegate>
{
//    NSMutableArray *sampleData;
}
@property (weak, nonatomic) IBOutlet UITextField *productNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *productPriceTextField;
@property (weak, nonatomic) IBOutlet UITextField *productQuantityTextField;
@property (strong, nonatomic) DownPicker *downPicker;
- (IBAction)clearButtonPressed:(id)sender;
@end
