//
//  Server.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "Server.h"

@implementation Server

NSInteger counter;

+(Server *)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(NSDictionary *) fetchDataFromDestination:(NSString*)destination WithData:(NSDictionary *)data{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *post = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[@"http://95.85.59.211/" stringByAppendingString:destination]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    
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
    NSLog(@"%@", result);
    return result;
}

-(void) startIndicator{
    if(!counter){
        counter = 0;
    }
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
