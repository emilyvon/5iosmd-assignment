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
@property (nonatomic, assign) id selectedObject;
@property (nonatomic, strong) NSString * selectedString;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation AddItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    sampleData = [[NSMutableArray alloc]init];
    [sampleData addObject:@"Item 1"];
    [sampleData addObject:@"Item 2"];
    [sampleData addObject:@"Item 3"];
    
//    [self.pickerView setShowsSelectionIndicator:YES];
//    
//    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
//    [toolBar setBarStyle:UIBarStyleDefault];
//    
//    SEL selector = @selector(hidePickerViewPressed:);
//    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:selector];
//    toolBar.items = @[flex, barButtonDone];
//    [toolBar setUserInteractionEnabled:YES];
//    barButtonDone.tintColor = [UIColor redColor];
//    
//    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, toolBar.frame.size.height + self.pickerView.frame.size.height)];
//    inputView.backgroundColor = [UIColor clearColor];
//    
//    [inputView addSubview:toolBar];
//
//   
//    
//    [self.pickerView addSubview:toolBar];
    
    
    _stringsArray = @[@"Easy to use", @"Time-saver", @"Customizable", @"Only a few lines of code", @"Works with custom fonts"];
    _objectsArray = [NSArray arrayWithObjects: @"hello", @14, @13.3, @"Icecream", @1,  nil];
    
    _selectedObject = [_objectsArray objectAtIndex:0];
    _selectedString = [_stringsArray objectAtIndex:0];
    
    
    


}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [sampleData objectAtIndex:row];
    }
    return 0;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [sampleData count];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)showPickerViewPressed:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.pickerView.frame = CGRectMake(0, 400, [UIScreen mainScreen].bounds.size.width, 261);
    [UIView commitAnimations];
}

- (IBAction)hidePickerViewPressed:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.pickerView.frame = CGRectMake(0, 700, [UIScreen mainScreen].bounds.size.width, 261);
    [UIView commitAnimations];
}

- (IBAction)chooseCategoryPressed:(id)sender {
    [MMPickerView showPickerViewInView:self.view
                           withStrings:_stringsArray
                           withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                         MMtextColor: [UIColor blackColor],
                                         MMtoolbarColor: [UIColor whiteColor],
                                         MMbuttonColor: [UIColor blueColor],
                                         MMfont: [UIFont systemFontOfSize:18],
                                         MMvalueY: @3,
                                         MMselectedObject:_selectedString,
                                         MMtextAlignment:@1}
                            completion:^(NSString *selectedString) {
                                _label.text = selectedString;
                                
                                _selectedString = selectedString;
                            }];
}

@end
