//
//  UserTestCase.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 29/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "User.h"
#import "Server.h"

@interface ValidUserLoginTestCase : XCTestCase<SignInDelegate>



@end

@implementation ValidUserLoginTestCase

- (void)setUp{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testUserSignIn{
    User *user = [[User alloc] init];
    [user loginWithEmail:@"test@gmail.com" andPassword:@"test1234"];
}

- (void) userValidated{
    
}

- (void) userFailedValidationWithMessage:(NSString *)message{
    
}

@end
