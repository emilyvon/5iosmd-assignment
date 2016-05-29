//
//  AddressViewController.m
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying FENG on 13/04/2016.
//  Copyright (c) 2016 Mengying FENG. All rights reserved.
//

#import "AddressViewController.h"
#import "Address.h"
#include <sqlite3.h>
#import "AppDelegate.h"

@interface AddressViewController ()

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
}

-(void)viewWillAppear:(BOOL)animated {
    [self reloadTableData];
}

-(void)reloadTableData {
    NSLog(@"reloadTableData");
    
    [self loadDataFromDb];
    [_tableView reloadData];
}

-(void)loadDataFromDb {
    NSLog (@"loadDataFromDb");
    
    sqlite3 *db;
    
    addressListArray = [[NSMutableArray alloc]initWithCapacity:100];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    const char *dbFilePathUTF8 = [appDelegate.dbFilePath UTF8String];
    if (sqlite3_open(dbFilePathUTF8, &db) == SQLITE_OK) {
        const char *sqlStatement = "select * from addresslist";
        sqlite3_stmt *compiledStatement;
        
        if (sqlite3_prepare_v2(db, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                NSString *aKey = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
                NSString *aStreet = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,1)];
                NSString *aSuburb = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,2)];
                NSString *aState = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,3)];
                NSString *aCountry = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,4)];
                
                Address *add = [[Address alloc]init];
                add.key = [aKey intValue];
                add.street = aStreet;
                add.suburb = aSuburb;
                add.state = aState;
                add.country = aCountry;
                [addressListArray addObject:add];
            }
        } else {
            NSLog(@"Failed to load addresslist");
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(db);
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual: @"AddAddress"]) {
        AddAddressViewController *addAddressVC = [segue destinationViewController];
        addAddressVC.myDelegate = self;
    }
}

-(void)addAddressViewControllerDismissed:(AddAddressViewController *)controller withAddress:(Address *)address {
    NSLog(@"Getting address back from AddAddressVC: %@",address.street);
    
}

- (IBAction)addAddress:(id)sender {
    [self performSegueWithIdentifier:@"AddAddress" sender:NULL];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [addressListArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"AddressListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    Address *add = [addressListArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [[NSString alloc]initWithFormat:@"%@ %@ %@ %@",add.street, add.suburb, add.state, add.country];
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Address *deleteObject = [addressListArray objectAtIndex:indexPath.row];
        [self deleteFromDB:deleteObject.key];
        [self reloadTableData];
    }
}

-(void) deleteFromDB:(long)key {
    sqlite3 *db;
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    const char *dbFilePathUTF8 = [appDelegate.dbFilePath UTF8String];
    
    if (sqlite3_open(dbFilePathUTF8, &db) == SQLITE_OK) {
        NSLog(@"Connection Opened!");
        
        sqlite3_stmt *compiledStatement;
        NSString *deleteStatementNS = [NSString stringWithFormat:@"delete from addresslist where key = %ld",key];
        const char *deleteStatement = [deleteStatementNS UTF8String];
        NSLog(deleteStatementNS);
        
        if (sqlite3_prepare_v2(db, deleteStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            NSLog(@"SQL Ok, delete OK");
            if (sqlite3_step(compiledStatement) != SQLITE_DONE) {
                NSLog(@"Error while deleting data");
            }
        } else {
            NSLog(@"delete addresslist failed!");
        }
        
        sqlite3_finalize(compiledStatement);
        sqlite3_close(db);
    }
    
    
    
    
}

@end
