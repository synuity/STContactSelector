//
//  ViewController.h
//  CustomContactPicker
//
//  Created by anoopkumar on 13/07/16.
//  Copyright © 2016 anoopkumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactPickerViewController.h"
#import <MessageUI/MessageUI.h>
@interface ViewController : UIViewController<CustContactProtocol,MFMessageComposeViewControllerDelegate>
{
    NSArray *messageArray;
    
    
    }

@end

