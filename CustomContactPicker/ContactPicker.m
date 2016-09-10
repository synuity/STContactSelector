//
//  ContactPicker.m
//  CustomContactPicker
//
//  Created by anoopkumar on 13/07/16.
//  Copyright © 2016 anoopkumar. All rights reserved.
//

#import "ContactPicker.h"

@implementation ContactPicker

static CNContactStore *contactStore;

+ (void)requestForAcces:(void(^)(BOOL granted))block{
    
    CNAuthorizationStatus authStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    contactStore = [[CNContactStore alloc]init];
    switch (authStatus) {
        case CNAuthorizationStatusAuthorized:
            block(true);
            break;
        case CNAuthorizationStatusDenied:
        case CNAuthorizationStatusNotDetermined:
        case CNAuthorizationStatusRestricted:
        {
            
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    block(true);
                }else{
                    block(false);
                }
            }];
            break;
            
        }
        default:
            block(false);
            break;
    }
    
}
//[contactStore enumerateContactsWithFetchRequest:fetchRequest error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
//    
//    
//    NSLog(@"coantct info == %@",contact);
//}];
//
//
//if (error) {
//    NSLog(@"Error.desc== %@",error.debugDescription);
//}

+ (NSArray *)fetchAllContacts{
    
   NSArray *keys = @[CNContactPhoneNumbersKey,CNContactGivenNameKey,CNContactThumbnailImageDataKey,CNContactImageDataKey,CNContactPhoneticMiddleNameKey,CNContactNameSuffixKey];
    
    NSPredicate *predicate = [CNContact predicateForContactsInContainerWithIdentifier:contactStore.defaultContainerIdentifier];
                           NSError *error;
                           NSArray *contactsArray = [contactStore unifiedContactsMatchingPredicate:predicate keysToFetch:keys error:&error];
    
    if (error) {
        NSLog(@"Error.desc== %@",error.debugDescription);
    }
    return contactsArray;
    
}

@end
