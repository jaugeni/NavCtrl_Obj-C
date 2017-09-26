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

-(void)addNewCompany:(NSString*)name withTicker:(NSString*)ticker{
    CompanyClass *tempCompany = [[CompanyClass alloc] init];
    tempCompany.companyName = name;
    if ([ticker isEqualToString:@""])  {
        tempCompany.stockTicker = @"N/A";
    } else {
        tempCompany.stockTicker = ticker;
    }
    tempCompany.currentPrice = [[NSString alloc] init];
    tempCompany.products = [[NSMutableArray alloc] init];
    [self.companyList addObject:tempCompany];
}

-(void)editCompany:(NSString*)name withTicker:(NSString*)ticker andCompanyIndex:(int)index{
    CompanyClass* currentCompany = self.companyList[index];
    currentCompany.companyName = name;
    if (ticker == NULL) {
        currentCompany.stockTicker = @"N/A";
    } else {
        currentCompany.stockTicker = ticker;
    }
    [self.companyList replaceObjectAtIndex:index withObject:currentCompany];
}

-(void)addNewProduct:(NSString*)name withCompany:(NSMutableArray*)array{
    
    ProductClass *tempProduct = [[ProductClass alloc] init];
    tempProduct.productName = name;
    [array addObject:tempProduct];
}

-(void)editProduct:(NSString*)name withProduct:(ProductClass*)currentProduct andProductIndex:(int)index{
    currentProduct.productName = name;
    [self.companyList replaceObjectAtIndex:index withObject:currentProduct];
}



-(void)createCompanye{
    
    CompanyClass *apple = [[CompanyClass alloc] init];
    CompanyClass *samsung = [[CompanyClass alloc] init];
    CompanyClass *tesla = [[CompanyClass alloc] init];
    CompanyClass *google = [[CompanyClass alloc] init];
    
    apple.companyName = @"Apple inc";
    apple.stockTicker = @"AAPL";
    apple.currentPrice = [[NSString alloc] init];
    samsung.companyName = @"Samsung inc";
    samsung.stockTicker = @"N/A";
    samsung.currentPrice = [[NSString alloc] init];
    tesla.companyName = @"Tesla inc";
    tesla.stockTicker = @"TSLA";
    tesla.currentPrice = [[NSString alloc] init];
    google.companyName = @"Google inc";
    google.stockTicker = @"GOOGL";
    google.currentPrice = [[NSString alloc] init];
    
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
