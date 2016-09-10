
//  ContactPickerViewController.m
//  CustomContactPicker
//
//  Created by anoopkumar on 13/07/16.
//  Copyright © 2016 anoopkumar. All rights reserved.
//

#import "ContactPickerViewController.h"
#import "ContactPicker.h"
#import "ContactTableViewCell.h"




@interface ContactPickerViewController ()
{
    __weak IBOutlet UITableView *contactTableView;
    __weak IBOutlet UIButton *donebutton;
    
}
@end

@implementation ContactPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [ContactPicker requestForAcces:^(BOOL granted) {
        if (granted) {
            [self getContacts];
        }else{
            NSLog(@"Not granted");
        }
    }];
    
    messageContactArray = [[NSMutableArray alloc]init];
    
//    UITapGestureRecognizer *tapgesture =[[UITapGestureRecognizer alloc]initWithTarget:self
//                                                                               action:@selector(tapOnScreen:)];
//    tapgesture.numberOfTapsRequired = 1;
//    [self.view addGestureRecognizer:tapgesture];
//    contactTableView.rowHeight  = UITableViewAutomaticDimension;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getAllContacts

- (void)getContacts
{
    myContactOriginalArray = [ContactPicker fetchAllContacts];
    filteredArray = myContactOriginalArray;
    [contactTableView reloadData];
}


#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  filteredArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier= @"contactCellID";
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell =[[ContactTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    CNContact *contact= (CNContact *)[filteredArray objectAtIndex:indexPath.row];
    
    [cell setcellData:contact];
    [cell setCompletion:^(BOOL value) {
        [self tableView:tableView didSelectRowAtIndexPath:indexPath];
        
    }];
    
    cell.btnSelect.selected= [messageContactArray containsObject:[self phoneStringFromCotnactOBject:contact]];
//    [self.btnPegAllUser setSelected:_peggedArray.count == allPegUserArray.count];
//    if ([messageContactArray containsObject:[self phoneStringFromCotnactOBject:contact]]) {
//        cell.accessoryType =UITableViewCellAccessoryCheckmark;
//    }else{
//        cell.accessoryType =UITableViewCellAccessoryNone;
//    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    
    
    [self CreateMessageArray:(CNContact *)[filteredArray objectAtIndex:indexPath.row]];
    
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];

    
    
}

- (BOOL)CreateMessageArray:(CNContact *)contact{
  
    
    BOOL added= false;
    
    NSString *phoneString = [self phoneStringFromCotnactOBject:contact];
    
    if ([messageContactArray containsObject:phoneString]) {
        [messageContactArray removeObject:phoneString];
        
    }
    else if(phoneString){
        [messageContactArray addObject:phoneString];
       added = true;
    }
    
    return added;
    

}

#pragma mark - tapGesture

- (void)tapOnScreen:(UITapGestureRecognizer *)tapGesture{
    [self.view endEditing:YES];
}


#pragma mark - IBACTIONS

- (IBAction)btnDoneClicked:(UIButton *)sender{
    
    
    [self dismissViewControllerAnimated:YES completion:^{
    
    [_conDelegate ContactPickerFinishSelectingContact:messageContactArray];
    
        //[self showMessageComposerView];
    }];
    
}
- (IBAction)btnCancelTapped:(UIButton *)sender{
    [self.view endEditing:true];
    [self dismissViewControllerAnimated:YES completion:^{
        [_conDelegate ContactPickerCancelSelectingContacs];
        
    }];
}


#pragma mark - searchBardelegae
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.view endEditing:YES];
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"SELF.givenName contains[cd] %@",searchBar.text];
    
    filteredArray = [myContactOriginalArray filteredArrayUsingPredicate:searchPredicate];
    [contactTableView reloadData];

    }// called when keyboard search button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.view endEditing:YES];
    
    filteredArray =myContactOriginalArray;
    [contactTableView reloadData];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"SELF.givenName contains[cd] %@",searchBar.text];
    
    filteredArray = [myContactOriginalArray filteredArrayUsingPredicate:searchPredicate];
    [contactTableView reloadData];

}
-(NSString *)phoneStringFromCotnactOBject:(CNContact *)cont{
    CNLabeledValue *cnLabeledPhoneNumValue = cont.phoneNumbers.firstObject;
    
    CNPhoneNumber *cnPhoneNumber = cnLabeledPhoneNumValue.value;
    NSString *phoneNumberString = cnPhoneNumber.stringValue;
    return phoneNumberString;
    
}
-(void) showAlert:(NSString *)string
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Contact Test"
                                 message:string
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No, thanks"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle no, thanks button
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}
@end
