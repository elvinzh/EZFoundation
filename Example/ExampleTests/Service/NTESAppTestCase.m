//
//  NTESModuleCenterTestCase.m
//  ExampleTests
//
//  Created by amao on 2019/1/28.
//  Copyright © 2019 amao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NTESExampleAModule.h"
#import "NTESExampleBModule.h"
#import <NTESFoundation/NTESFoundation.h>

@interface NTESAppTestCase : XCTestCase

@end

@implementation NTESAppTestCase

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testModule
{
    [NTESApp.shared launch:^{
        NTESLoggerConfiguration *configuration = [NTESLoggerConfiguration new];
        configuration.dir = NSTemporaryDirectory();
        NTESLogger.shared.configuration = configuration;
    }];
    

    {
        id<NTESExampleAService> aService = [NTESApp.shared serviceByProtocol:@protocol(NTESExampleAService)];
        XCTAssertNotNil(aService);
        id<NTESExampleBDataService> bService = [NTESApp.shared serviceByProtocol:@protocol(NTESExampleBDataService)];
        XCTAssertNil(bService);
    }
    
    {
        id<NTESExampleAService> aService = [NTESApp.shared userDataServiceByProtocol:@protocol(NTESExampleAService)];
        XCTAssertNil(aService);
        id<NTESExampleBDataService> bService = [NTESApp.shared userDataServiceByProtocol:@protocol(NTESExampleBDataService)];
        XCTAssertNil(bService);
    }
    
    {
        id<NTESExampleAService> oldA = [NTESApp.shared serviceByProtocol:@protocol(NTESExampleAService)];
        id<NTESExampleBDataService> oldB = [NTESApp.shared userDataServiceByProtocol:@protocol(NTESExampleBDataService)];
        XCTAssertNotNil(oldA);
        XCTAssertNil(oldB);
        
        NTESApp.shared.userId = @"1";
        id<NTESExampleAService> newA = [NTESApp.shared serviceByProtocol:@protocol(NTESExampleAService)];
        id<NTESExampleBDataService> newB = [NTESApp.shared userDataServiceByProtocol:@protocol(NTESExampleBDataService)];
        XCTAssertNotNil(newA);
        XCTAssertNotNil(newB);
        XCTAssertEqual(oldA, newA);
        
        NTESApp.shared.userId = @"2";
        id<NTESExampleAService> newnewA = [NTESApp.shared serviceByProtocol:@protocol(NTESExampleAService)];
        id<NTESExampleBDataService> newnewB = [NTESApp.shared userDataServiceByProtocol:@protocol(NTESExampleBDataService)];
        XCTAssertNotNil(newnewA);
        XCTAssertNotNil(newnewB);
        XCTAssertEqual(newnewA, newA);
        XCTAssertNotEqual(newnewB, newB);
    }
    
    
}
@end
