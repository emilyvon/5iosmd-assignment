//
//  AddAddressViewController.m
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying Feng on 17/04/2016.
//  Copyright © 2016 Mengying FENG. All rights reserved.
//

#import "AddAddressViewController.h"
#import "Address.h"

@interface AddAddressViewController ()
{
    Address *address;
}
@end

@implementation AddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addButtonPressed:(id)sender {
    if (![_streetTextField.text isEqual: @""] && ![_suburbTextField.text isEqual: @""] && ![_stateTextField.text isEqual: @""] && ![_countryTextField.text isEqual: @""]) {
        
        address = [[Address alloc]initWithStreet:_streetTextField.text suburb:_suburbTextField.text state:_stateTextField.text country:_countryTextField.text];
        
        
        sqlite3 *db;
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        const char *dbFilePathUTF8 = [appDelegate.dbFilePath UTF8String];
        
        if (sqlite3_open(dbFilePathUTF8, &db) == SQLITE_OK) {
            
            sqlite3_stmt *compiledStatement;
            NSString *insertStatementNS = [NSString stringWithFormat:@"insert into addresslist (street,suburb,state,country) values (\"%@\",\"%@\",\"%@\",\"%@\")", _streetTextField.text, _suburbTextField.text, _stateTextField.text, _countryTextField.text];
            NSLog(@"%@",insertStatementNS);
            
            const char *insertStatement = [insertStatementNS UTF8String];
            if (sqlite3_prepare_v2(db,insertStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
                NSLog(@"SQL Ok, insert OK");
                _streetTextField.text = @"";
                _suburbTextField.text = @"";
                _stateTextField.text = @"";
                _countryTextField.text = @"";
                if (sqlite3_step(compiledStatement) != SQLITE_DONE) {
                    NSLog(@"Error while inserting data");
                }
                
            } else {
                NSLog(@"insert failed!");
            }
            sqlite3_finalize (compiledStatement);
            sqlite3_close(db);
        }
        [self.myDelegate addAddressViewControllerDismissed:self withAddress:address];
        [self dismissViewControllerAnimated:YES completion:NULL];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"All fields must be filled in" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [ _streetTextField resignFirstResponder];
    [_suburbTextField resignFirstResponder];
    [_stateTextField resignFirstResponder];
    [_countryTextField resignFirstResponder];
    
}

@end
