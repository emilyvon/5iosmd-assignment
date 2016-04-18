//
//  OtherViewController.m
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying FENG on 13/04/2016.
//  Copyright (c) 2016 Mengying FENG. All rights reserved.
//

#import "OtherViewController.h"

@interface OtherViewController ()

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_emailTableView setDelegate:self];
    [_emailTableView setDataSource:self];

    
    emailArray = [[NSMutableArray alloc]init];
    [emailArray addObject:@"emily@hotmail.com"];
    [emailArray addObject:@"emily@outlook.com"];
    [emailArray addObject:@"emily@gmail.com"];
    [emailArray addObject:@"emily@yahoo.com"];
}

// MARK: MFMailComposeViewControllerDelegate

- (IBAction)sendMailButtonPressed:(id)sender {
    //http://www.appcoda.com/ios-programming-101-send-email-iphone-app/
    NSString *title = @"Your order summay";
    NSString *body = @"This is your order summary: ";
    NSArray *toEmails = [NSArray arrayWithObject:@"emilyfung86@hotmail.com"];
    
    
    mailComposer = [[MFMailComposeViewController alloc]init];
    mailComposer.mailComposeDelegate = self;
    [mailComposer setSubject:title];
    [mailComposer setMessageBody:body isHTML:NO];
    [mailComposer setToRecipients:toEmails];
    [self presentViewController:mailComposer animated:YES completion:nil];
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
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_emailTableView cellForRowAtIndexPath:indexPath].selectionStyle = UITableViewCellSelectionStyleDefault;
    if ([_emailTableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark) {
        [_emailTableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    } else {
        [_emailTableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

@end
