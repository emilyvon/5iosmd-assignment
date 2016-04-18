//
//  OtherViewController.h
//  5IOSMD_Assignment_MengyingFENG
//
//  Created by Mengying FENG on 13/04/2016.
//  Copyright (c) 2016 Mengying FENG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface OtherViewController : UIViewController <MFMailComposeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>
{
    MFMailComposeViewController *mailComposer;
    NSMutableArray *emailArray;
}
@property (weak, nonatomic) IBOutlet UITableView *emailTableView;
- (IBAction)sendMailButtonPressed:(id)sender;


@end
