//
//  TotalViewController.m
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying FENG on 13/04/2016.
//  Copyright (c) 2016 Mengying FENG. All rights reserved.
//

#import "TotalViewController.h"
#import "ShoppingList.h"
#import "ShoppingListTableViewCell.h"

@interface TotalViewController ()
{
    NSMutableArray *items;
}
@end

@implementation TotalViewController


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
    [self updateTotal];
}

-(void)updateTotal {
    double price = 0;
    ShoppingList *list;
    for (int x = 0; x<[shoppingListArray count]; x++) {
        list = shoppingListArray[x];
        price += list.price;
    }
    _totalAmountLabel.text = [NSString stringWithFormat:@"Total: $ %0.2f",price];
    [[NSUserDefaults standardUserDefaults]setValue:_totalAmountLabel.text forKey:@"totalPrice"];
}

#pragma mark - Database

- (void) loadDataFromDb {
    NSLog (@"loadDataFromDb");
    
    sqlite3 *db;
    
    shoppingListArray = [[NSMutableArray alloc] initWithCapacity: 100]; // arbitrary capacity
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    const char* dbFilePathUTF8 = [appDelegate.dbFilePath UTF8String];
    //    NSLog(@"dbFilePathUTF8 %s", dbFilePathUTF8);
    // Open the database from the users filessytem
    if(sqlite3_open(dbFilePathUTF8, &db) == SQLITE_OK) {
        // Setup the SQL Statement and compile it for faster access
        const char *sqlStatement = "select * from shoppinglist";
        sqlite3_stmt *compiledStatement;
        
        // store result in compiledStatement
        if(sqlite3_prepare_v2(db, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                // Read the data from the result row
                NSString *aItem = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                NSString *aPrice = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                NSString *aQuantity = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
                NSString *aGroupid = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                NSString *url = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
                NSString *aKey = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                
                // Create a new object with the data from the database
                ShoppingList *aList = [[ShoppingList alloc] init];
                aList.item = aItem;
                aList.price = [aPrice doubleValue];
                aList.quantity = [aQuantity intValue];
                aList.groupid = [aGroupid intValue];
                aList.key = [aKey intValue];
                aList.imageUrl = url;
                
                [shoppingListArray addObject:aList];
                
                items = [[NSMutableArray alloc]init];
                [items addObject:aItem];
                
                
//                [[DataService sharedService]setStoredShoppingListItem:aItem];
            }
            [[NSUserDefaults standardUserDefaults]setObject:items forKey:@"shoppingListItems"];
        } else {
            NSLog(@"Failed to load shoppinglist");
        }
        
        // Release the compiled statement from memory
        sqlite3_finalize(compiledStatement);
    }
    
    // done with the db.
    sqlite3_close(db);
}

-(void)deleteFromDb:(long)keyField {
    sqlite3 *db;
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    const char *dbFilePathUTF8 = [appDelegate.dbFilePath UTF8String];
    
    if (sqlite3_open(dbFilePathUTF8, &db) == SQLITE_OK) {
        NSLog(@"Connection Opened!");
        
        sqlite3_stmt *compiledStatement;
        NSString *deleteStatementNS = [NSString stringWithFormat:@"delete from shoppinglist where key = %ld",keyField];
        const char *deleteStatement = [deleteStatementNS UTF8String];
        NSLog(deleteStatementNS);
        
        if (sqlite3_prepare_v2(db, deleteStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            NSLog(@"SQL Ok, delete OK");
            if (sqlite3_step(compiledStatement) != SQLITE_DONE) {
                NSLog(@"Error while deleting data");
            }
        } else {
            NSLog(@"delete shoppinplist failed!");
        }
        
        sqlite3_finalize(compiledStatement);
        sqlite3_close(db);
    }
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [shoppingListArray count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"ShoppingListCell";
    ShoppingListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell == nil ) {
        cell = [[ShoppingListTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    // populate data to tableview
    ShoppingList *shoppingList = [shoppingListArray objectAtIndex:indexPath.row];
    NSArray *categories = [[DataService sharedService]getCategories];

    cell.nameLabel.text = shoppingList.item;
    cell.priceLabel.text = [[NSString alloc]initWithFormat:@"$%.02f", shoppingList.price];
    cell.quantityLabel.text = [[NSString alloc]initWithFormat:@"Qty: %d", shoppingList.quantity];
    cell.categoryLabel.text = [categories objectAtIndex:shoppingList.groupid];
    
    if ([[NSFileManager defaultManager]fileExistsAtPath:shoppingList.imageUrl]) {
        NSData *data = [[NSFileManager defaultManager]contentsAtPath:shoppingList.imageUrl];
        cell.img.image = [UIImage imageWithData:data];
        UIColor *color = [UIColor whiteColor];
        switch (shoppingList.groupid) {
            case 0:
                color = [UIColor lightGrayColor];
                break;
            case 1:
                color = [UIColor lightGrayColor];
                break;
            case 2:
                color = [UIColor lightGrayColor];
                break;
            case 3:
                color = [UIColor lightGrayColor];
                break;
            case 4:
                color = [UIColor lightGrayColor];
                break;
            default:
                break;
        }
        cell.categoryLabel.backgroundColor = color;
        
    } else {
        cell.img.image = [UIImage imageNamed:@"icon.png"];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ShoppingList *deleteObject = [shoppingListArray objectAtIndex:indexPath.row];
        [self deleteFromDb:deleteObject.key];
        [self reloadTableData];
    }
}

@end
