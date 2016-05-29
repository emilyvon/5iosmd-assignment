//
//  OtherViewController.m
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying FENG on 13/04/2016.
//  Copyright (c) 2016 Mengying FENG. All rights reserved.
//

#import "OtherViewController.h"

@interface OtherViewController ()
{
    NSMutableArray *selectedEmails;
}
@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _emailTableView.allowsMultipleSelection = YES;
    
    [_emailTableView setDelegate:self];
    [_emailTableView setDataSource:self];
    
    
    emailArray = [[NSMutableArray alloc]init];
    [emailArray addObject:@"41663316@foxmail.com"];
    [emailArray addObject:@"41663316@outlook.com"];
    [emailArray addObject:@"emilyfung@outlook.com.au"];
    [emailArray addObject:@"emilyfung86@hotmail.com"];
    
    selectedEmails = [[NSMutableArray alloc]initWithCapacity:50];
    
    
    
}

// MARK: MFMailComposeViewControllerDelegate

- (IBAction)sendMailButtonPressed:(id)sender {
    
    if (selectedEmails.count < 1) {
        alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please select at least one email." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    } else {
        alert = [[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"Send order to selected emails?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    }
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSString *price = [[NSUserDefaults standardUserDefaults]valueForKey:@"totalPrice"];
        
        NSString *title = @"Your order summay";
        NSString *body = [[NSString alloc]initWithFormat:@"Your order summary: \n\n%@", price];
        NSArray *toEmails = selectedEmails;
        
        mailComposer = [[MFMailComposeViewController alloc]init];
        mailComposer.mailComposeDelegate = self;
        [mailComposer setSubject:title];
        [mailComposer setMessageBody:body isHTML:NO];
        [mailComposer setToRecipients:toEmails];
        [self presentViewController:mailComposer animated:YES completion:nil];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    if (result) {
        NSLog(@"Result : %d", result);
    }
    if (error) {
        NSLog(@"Error : %@", error);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

// MARK: UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [emailArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"emailCell";
    UITableViewCell *cell = [_emailTableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = [emailArray objectAtIndex:indexPath.row];
    UIView * bg = [[UIView alloc]init];
    bg.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:97.0/255.0 blue:100.0/255.0 alpha:0.20];
    [cell setSelectedBackgroundView:bg];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *txt = cell.textLabel.text;
    [selectedEmails addObject:txt];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *txt = cell.textLabel.text;
    [selectedEmails removeObject:txt];
}
@end
