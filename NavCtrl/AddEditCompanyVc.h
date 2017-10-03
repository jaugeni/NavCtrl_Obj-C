//
//  AddEditCompanyVc.h
//  NavCtrl
//
//  Created by YAUHENI IVANIUK on 9/22/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dao.h"

@interface AddEditCompanyVc : UIViewController<UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UIButton *deleteByn;

@property (retain, nonatomic) IBOutlet UITextField *addEditCompanyName;
@property (retain, nonatomic) IBOutlet UITextField *addEditTicker;
@property (retain, nonatomic) IBOutlet UITextField *addEdditImageCompanyLink;
- (IBAction)deletePressed:(id)sender;

@property (nonatomic) BOOL flagIsAddMod;
@property (nonatomic) int currentCompanyIndex;



@end
