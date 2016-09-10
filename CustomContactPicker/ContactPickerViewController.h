//
//  ContactPickerViewController.h
//  CustomContactPicker
//
//  Created by synuity on 13/07/16.
//  Copyright © 2016 synuity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>



@protocol CustContactProtocol <NSObject>

@optional
- (void)ContactPickerFinishSelectingContact:(NSArray *)contactArry;
- (void)ContactPickerCancelSelectingContacs;

@end
@interface ContactPickerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{
    NSArray *myContactOriginalArray,*filteredArray;
    NSMutableArray *messageContactArray;
    
    
}

@property (nonatomic, weak) id <CustContactProtocol> conDelegate;


@end
