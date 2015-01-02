//
//  Server.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 Steffen Rudkjøbing. All rights reserved.
//

#import "Server.h"
#import "AppDelegate.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation Server

NSInteger counter = 0;

- (Server*) init{
    self = [super init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults integerForKey:@"cookieId"] && [defaults stringForKey:@"cookie"] && [defaults integerForKey:@"userId"] ){
        self.cookieId = [defaults objectForKey:@"cookieId"];
        self.cookie = [defaults stringForKey:@"cookie"];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.appState.userId = [[NSNumber alloc] initWithLong:[defaults integerForKey:@"userId"]];
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UserMustSignIn" object:self];
    }
    return self;
}

-(NSDictionary *) queryServerDomain:(NSString*)domain WithCommand:(NSString *)command andData:(NSDictionary *)inData{
    NSMutableDictionary *data   =   [inData mutableCopy];
    NSString *hashedNonce       =   @"";

    
    if(self.cookieId && self.cookie){
        NSString *nonce = [[NSUUID UUID] UUIDString];
        hashedNonce = [self hmacForKey:self.cookie AndData: nonce];
        NSMutableDictionary *cookie = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.cookieId, @"id", nonce, @"nonce", nil];
        [data setObject:cookie forKey:@"cookie"];
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *post = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", hashedNonce);
    NSLog(@"%@ %@", domain, command);
    NSLog(@"%@", post);
 
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:[NSURL URLWithString:@"https://gateway.beckon.dk/Beckon/router.php"]];
    [request setURL:[NSURL URLWithString:@"http://178.62.173.9/Beckon/router.php"]];
//    [request setURL:[NSURL URLWithString:@"http://192.168.1.230:8090/router.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:command forHTTPHeaderField:domain];
    [request setValue:hashedNonce forHTTPHeaderField:@"hash"];
    [request setValue:@"6752dad744e6ab1bd0e65dbf4f2ffc77" forHTTPHeaderField:@"appkey"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSHTTPURLResponse *response = nil;
    [self startIndicator];
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(error){
        NSLog(@"ERROR in transmission, %@", error.debugDescription);
    }
    [self stopIndicator];
    if(urlData == nil){
        NSLog(@"Result is NIL");
    }
    NSString *jsondata = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData: [jsondata dataUsingEncoding:NSUTF8StringEncoding]
                                                           options: NSJSONReadingMutableContainers
                                                             error: &error];
    if(error){
        NSLog(@"ERROR in translation, %@", error.debugDescription);
        result = [[NSDictionary alloc] init];
    }

    
    if([[result objectForKey:@"status"] isEqualToNumber:@(403)]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UserMustSignIn" object:self];
    }
    NSLog(@"%@", result);
    return result;
}

-(void) startIndicator{
    ++counter;
    if (counter == 1) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    }
    
}

-(void) stopIndicator{
    --counter;
    if (counter <= 0) {
        counter = 0;
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    }
}

- (NSString *)hmacForKey: (NSString *)key AndData: (NSString *)data
{
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    NSString *hash = [HMAC base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    return hash;
}

@end
