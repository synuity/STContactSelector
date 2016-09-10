//
//  ContactPickerViewController.h
//  CustomContactPicker
//
//  Created by anoopkumar on 13/07/16.
//  Copyright © 2016 anoopkumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>



@protocol CustContactProtocol <NSObject>

@optional
- (void)ContactPickerFinishSelectingContact:(NSArray *)contactArry;
- (void)ContactPickerCancelSelectingContacs;

@end
@interface ContactPickerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,MFMessageComposeViewControllerDelegate>

{
    NSArray *myContactOriginalArray,*filteredArray;
    NSMutableArray *messageContactArray;
    
    
}

@property (nonatomic, weak) id <CustContactProtocol> conDelegate;


@end
