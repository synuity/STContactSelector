//
//  ContactPicker.h
//  CustomContactPicker
//
//  Created by anoopkumar on 13/07/16.
//  Copyright © 2016 anoopkumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Contacts/Contacts.h>

@interface ContactPicker : NSObject{
    
    
}
+ (void)requestForAcces:(void(^)(BOOL granted))block;
+ (NSArray *)fetchAllContacts;

@end
