//
//  ContactTableViewCell.h
//  CustomContactPicker
//
//  Created by synuity on 14/07/16.
//  Copyright © 2016 synuity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Contacts/Contacts.h>

@interface ContactTableViewCell : UITableViewCell{

}
@property(weak,nonatomic)IBOutlet UIButton *btnSelect;
@property(nonatomic,copy)void(^completion)(BOOL value);


- (void)setcellData:(CNContact *)contatObject;

@end
