//
//  AddItemsViewController.m
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying FENG on 13/04/2016.
//  Copyright (c) 2016 Mengying FENG. All rights reserved.
//

#import "AddItemsViewController.h"

@interface AddItemsViewController ()
@property (nonatomic, strong) NSArray *stringsArray;
@property (nonatomic, strong) NSArray *objectsArray;
@property (nonatomic, strong) NSArray *numbersArray;
@property (weak, nonatomic) IBOutlet UITextField *categoryTextField;

@end

@implementation AddItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // create the array of data
    NSMutableArray* bandArray = [[NSMutableArray alloc] init];
    
    // add some sample data
    [bandArray addObject:@"Groceries"];
    [bandArray addObject:@"Electronic"];
    [bandArray addObject:@"Clothing"];
    [bandArray addObject:@"Home"];
    [bandArray addObject:@"Cosmetics"];
    [bandArray addObject:@"Health"];
    
    // bind yourTextField to DownPicker
    self.downPicker = [[DownPicker alloc] initWithTextField:self.categoryTextField withData:bandArray];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



- (IBAction)clearButtonPressed:(id)sender {
    _productNameTextField.text = @"";
    _productPriceTextField.text = @"";
    _productQuantityTextField.text = @"";
}
@end
