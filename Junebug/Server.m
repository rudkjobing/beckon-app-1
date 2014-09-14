//
//  Server.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "Server.h"
#import "AppDelegate.h"

@implementation Server

NSInteger counter;

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
    NSMutableDictionary *data = [inData mutableCopy];
    NSError *error;
    if(self.cookieId && self.cookie){
        NSMutableDictionary *cookie = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.cookieId, @"id", self.cookie, @"cookie", nil];
        [data setObject:cookie forKey:@"cookie"];
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *post = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
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
    [request setValue:@"6752dad744e6ab1bd0e65dbf4f2ffc77" forHTTPHeaderField:@"appkey"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    error = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
    [self startIndicator];
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    [self stopIndicator];
    /*[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;*/
    NSString *jsondata = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData: [jsondata dataUsingEncoding:NSUTF8StringEncoding]
                                                           options: NSJSONReadingMutableContainers
                                                             error: &error];
    if([[result objectForKey:@"message"] isEqualToString:@"Invalid Cookie"]){
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
    if (counter == 0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    }
}

@end
