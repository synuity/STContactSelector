//
//  ContactTableViewCell.h
//  CustomContactPicker
//
//  Created by anoopkumar on 14/07/16.
//  Copyright © 2016 anoopkumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Contacts/Contacts.h>

@interface ContactTableViewCell : UITableViewCell{

}
@property(weak,nonatomic)IBOutlet UIButton *btnSelect;
@property(nonatomic,copy)void(^completion)(BOOL value);


- (void)setcellData:(CNContact *)contatObject;

@end
