//
//  ContactTableViewCell.m
//  CustomContactPicker
//
//  Created by synuity on 14/07/16.
//  Copyright © 2016 synuity. All rights reserved.
//

#import "ContactTableViewCell.h"

@implementation ContactTableViewCell{
    __weak IBOutlet UILabel *lblname;
    __weak IBOutlet UILabel *lblPhonenumber;
    __weak IBOutlet UIImageView *contactImageView;
    __weak IBOutlet UILabel *textInitial;
    __weak IBOutlet UIView *cotainerView;
    
        
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    contactImageView.layer.cornerRadius = contactImageView.frame.size.height/2;
    cotainerView.layer.cornerRadius = cotainerView.frame.size.height/2;

    [contactImageView setClipsToBounds:true];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setcellData:(CNContact *)contatObject{
    contactImageView.image = nil;
    textInitial.text =@"";
    CNLabeledValue *cnLabeledPhoneNumValue = contatObject.phoneNumbers.firstObject;
    
    CNPhoneNumber *cnPhoneNumber = cnLabeledPhoneNumValue.value;
    NSString *phoneNumberString = cnPhoneNumber.stringValue;
    [lblPhonenumber setText:phoneNumberString];
    [lblname setText:contatObject.givenName];
        if (contatObject.imageData ) {
        [contactImageView setImage:[UIImage imageWithData:contatObject.thumbnailImageData]];
         
    }else{
        NSString *textMessage = [contatObject.givenName substringToIndex:2];
        textInitial.text = textMessage;
    }
   
    
}



- (IBAction)btnSelect:(id)sender{
    NSLog(@"Comel");
    _completion(true);
    
}
@end
