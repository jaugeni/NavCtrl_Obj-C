//
//  Dao.m
//  NavCtrl
//
//  Created by YAUHENI IVANIUK on 9/21/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "Dao.h"


@implementation Dao

+ (Dao *)sharedDao {
    static Dao *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
        [_sharedInstance createCompanye];
    });
    
    return _sharedInstance;
}

-(void)addNewCompany:(NSString*)name{
    
    CompanyClass *tempCompany = [[CompanyClass alloc] init];
    tempCompany.companyName = name;
    tempCompany.products = [[NSMutableArray alloc] init];
    [self.companyList addObject:tempCompany];
}

-(void)addNewProduct:(NSString*)name withCompany:(NSMutableArray*)array{
    
    ProductClass *tempProduct = [[ProductClass alloc] init];
    tempProduct.productName = name;
    [array addObject:tempProduct];
}



-(void)createCompanye{
    
    
    CompanyClass *apple = [[CompanyClass alloc] init];
    CompanyClass *samsung = [[CompanyClass alloc] init];
    CompanyClass *tesla = [[CompanyClass alloc] init];
    CompanyClass *google = [[CompanyClass alloc] init];
    
    apple.companyName = @"Apple inc";
    samsung.companyName = @"Samsung inc";
    tesla.companyName = @"Tesla inc";
    google.companyName = @"Google inc";
    
    ProductClass* iPad = [[ProductClass alloc] init];
    ProductClass* iPodTouch = [[ProductClass alloc] init];
    ProductClass* iPhone = [[ProductClass alloc] init];
    ProductClass* galaxyS4 = [[ProductClass alloc] init];
    ProductClass* galaxyNote = [[ProductClass alloc] init];
    ProductClass* galaxyTab = [[ProductClass alloc] init];
    ProductClass* googleCom = [[ProductClass alloc] init];
    ProductClass* pixel = [[ProductClass alloc] init];
    ProductClass* chrome = [[ProductClass alloc] init];
    ProductClass* modelX = [[ProductClass alloc] init];
    ProductClass* powerwall = [[ProductClass alloc] init];
    ProductClass* solarPanels = [[ProductClass alloc] init];
    
    iPad.productName = @"iPad";
    iPodTouch.productName = @"iPod Touch";
    iPhone.productName = @"iPhone";
    galaxyS4.productName = @"Galaxy S4";
    galaxyNote.productName = @"Galaxy Note";
    galaxyTab.productName = @"Galaxy Tab";
    googleCom.productName = @"google.com";
    pixel.productName = @"google pixel";
    chrome.productName = @"Chrome";
    modelX.productName = @"Model X";
    powerwall.productName = @"Powerwall";
    solarPanels.productName = @"Solar Panels";
    
    self.companyList = [[NSMutableArray alloc] initWithObjects: apple,samsung,tesla,google, nil];
    
    NSLog(@"%@", self.companyList);
    
    apple.products = [[NSMutableArray alloc] initWithArray:@[iPad,iPhone,iPodTouch]];
    google.products = [[NSMutableArray alloc] initWithArray:@[googleCom,pixel,chrome]];
    tesla.products = [[NSMutableArray alloc] initWithArray:@[modelX,powerwall,solarPanels]];
    samsung.products = [[NSMutableArray alloc] initWithArray:@[galaxyS4,galaxyTab,galaxyNote]];
}
@end
