//
//  AddItemsViewController.m
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying FENG on 13/04/2016.
//  Copyright (c) 2016 Mengying FENG. All rights reserved.
//

#import "AddItemsViewController.h"



@interface AddItemsViewController ()
{
    NSArray* categoryArray;
    NSData *imageData;
    NSString *filePath;
}
@property (nonatomic, strong) NSArray *stringsArray;
@property (nonatomic, strong) NSArray *objectsArray;
@property (nonatomic, strong) NSArray *numbersArray;
@property (weak, nonatomic) IBOutlet UITextField *categoryTextField;

@end

@implementation AddItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _resultLabel.hidden = YES;
    // create the array of data
    categoryArray = [[NSArray alloc] init];
    
    categoryArray = [[DataService sharedService]getCategories];
    
    // bind yourTextField to DownPicker
    self.downPicker = [[DownPicker alloc] initWithTextField:self.categoryTextField withData:categoryArray];
}

-(void)viewWillAppear:(BOOL)animated {
    _resultLabel.hidden = YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

// MARK: UIImagePickerControllerDelegate

- (IBAction)pickImageButtonPressed:(id)sender {
    
    imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    _productImageView.image = chosenImage;
    
    // save the selected image as NSData to Document Directory
    imageData = UIImagePNGRepresentation(chosenImage);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd_hh:mm:ss"];
    NSString *timeStamp = [DateFormatter stringFromDate:[NSDate date]];
    filePath = [documentPath stringByAppendingPathComponent:timeStamp]; // save filePath to SQLite
    [imageData writeToFile:filePath atomically:YES]; // save image as NSData to phone
    
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
}

// MARK: Clear Button Pressed
- (IBAction)clearButtonPressed:(id)sender {
    _productNameTextField.text = @"";
    _productPriceTextField.text = @"";
    _productQuantityTextField.text = @"";
    _categoryTextField.text = @"";
    _productImageView.image = [UIImage imageNamed:@"camera.png"];
}

// MARK: Add Button Pressed
- (IBAction)addButtonPressed:(id)sender {
    if (([_productNameTextField.text length] == 0) || ([_productPriceTextField.text length] == 0) || ([_productQuantityTextField.text length] == 0) || ([_categoryTextField.text length] == 0)) {
        
        // show alert
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"All fields must be filled in" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
        return;
    }
    
    sqlite3 *db;
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    const char *dbFilePathUTF8 = [appDelegate.dbFilePath UTF8String];
    
    // Open the database from the users filessytem
    if(sqlite3_open(dbFilePathUTF8, &db) == SQLITE_OK) {
        NSLog(@"Connection Opened!");
        
        sqlite3_stmt *compiledStatement; // database prepared statement
        
        NSString *insertStatementNS = [NSString stringWithFormat:@"insert into shoppinglist (item,price,groupid,quantity,imageUrl) values (\"%@\",%@,%lu,%@, \"%@\")", _productNameTextField.text, _productPriceTextField.text, (unsigned long)[categoryArray indexOfObject:_categoryTextField.text], _productQuantityTextField.text, filePath];
        
        NSLog(@"%@",insertStatementNS);
        
        const char *insertStatement = [insertStatementNS UTF8String];
        
        if(sqlite3_prepare_v2(db, insertStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            NSLog(@"SQL Ok, insert OK");
            
            //            _resultLabel.hidden = NO;
            
            [self setView:_resultLabel hidden:NO];
            
            
            // clear fields and indicate success on status line
            _productNameTextField.text = @"";
            _productPriceTextField.text = @"";
            _productQuantityTextField.text = @"";
            _categoryTextField.text = @"";
            _productImageView.image = [UIImage imageNamed:@"camera.png"];
            
            if(sqlite3_step(compiledStatement) != SQLITE_DONE){
                NSLog(@"Error while inserting data");
            }
        } else {
            NSLog(@"insert failed!");
        }
        
        // done with the db.  finalize the statement and close
        sqlite3_finalize (compiledStatement);
        sqlite3_close(db);
        
        double delayInSeconds = 1.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            NSLog(@"Do some work");
            [self setView:_resultLabel hidden:YES];
        });
    }
}

-(void)setView:(UIView *)view hidden:(BOOL)hidden {
    [UIView transitionWithView:view duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [view setHidden:hidden];
    } completion:nil];
}
@end
