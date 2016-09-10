//
//  ViewController.m
//  CustomContactPicker
//
//  Created by synuity on 13/07/16.
//  Copyright © 2016 synuity. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBACTION

- (IBAction)btnShowContactClicked:(UIButton *)sender{
    
    ContactPickerViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"contactPickerVC"];
    [self.navigationController presentViewController:controller animated:YES completion:^{
        [controller setConDelegate:self];
    }];
}


#pragma mark - ContactPicker Delegate....

-(void)ContactPickerFinishSelectingContact:(NSArray *)contactArry{
       
    if (contactArry.count) {
        messageArray= contactArry;
        [self showAlert:[NSString stringWithFormat:@"Number of contact selected is = %lu",(unsigned long)contactArry.count]];
          [self showMessageComposerView];
    }
    
}

- (void)ContactPickerCancelSelectingContacs{
    [self showAlert:@"No Contact is Selected"];
}



#pragma mark - messageComposerViewController

- (void)showMessageComposerView{
    [self.view endEditing:YES];
    
    if(![MFMessageComposeViewController canSendText]) {
        [self showAlert:@"Your device doesn't support SMS!"];
        
        return;
    }
    
    if (messageArray.count) {
        NSString *message= [NSString stringWithFormat:@"Hi Your custom message here..."];
        MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
        messageController.messageComposeDelegate = self;
        [messageController setRecipients:messageArray];
        [messageController setBody:message];
        [self presentViewController:messageController animated:YES completion:nil];
    }
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
        case MessageComposeResultFailed:
        {
            [self showAlert:@"Failed to send SMS!"];
            break;
        }
            
        case MessageComposeResultSent:
            [self showAlert:@"SMS Sent!"];
            break;
            
        default:
            break;
    }
    
    [controller dismissViewControllerAnimated:NO completion:^{
        
    }];
    
}



#pragma mark - uialertView

-(void) showAlert:(NSString *)string
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Contact"
                                 message:string
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Okay"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                }];
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}



@end
