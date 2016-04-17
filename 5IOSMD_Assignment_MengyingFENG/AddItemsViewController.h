//
//  AddItemsViewController.h
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying FENG on 13/04/2016.
//  Copyright (c) 2016 Mengying FENG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMPickerView.h"
@interface AddItemsViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSMutableArray *sampleData;
}
- (IBAction)showPickerViewPressed:(id)sender;
- (IBAction)hidePickerViewPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@end
