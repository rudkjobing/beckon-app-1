//
//  Beckons.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "Beckons.h"
#import "BeckonCell.h"
#import "Beckon.h"

@implementation Beckons


- (void) getAllBeckons{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSDictionary *data = [[NSDictionary alloc] init];
        NSDictionary *result = [self.server queryServerDomain:@"beckon" WithCommand:@"getAll" andData:data];
        /*for(int i = 0 ; i < 1000 ; i++){
            [self.server queryServerDomain:@"beckon" WithCommand:@"getAll" andData:data];
        }*/
        dispatch_async(dispatch_get_main_queue(), ^{
            if([[result objectForKey:@"success"] isEqualToString:@"1"]){
                NSArray *payload = [result objectForKey:@"payload"];
                [self.beckons removeAllObjects];
                for(NSDictionary *child in payload){
                    Beckon *beckon = [[Beckon alloc] init];
                    beckon.id = [child objectForKey:@"id"];
                    beckon.title = [child objectForKey:@"title"];
                    beckon.server = self.server;
                    [self.beckons addObject: beckon];
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"BeckonsFetched" object:self];
            }
            else{
                
            }
        });
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.beckons.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =@"BeckonCell";
    BeckonCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[BeckonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    Beckon *beckon = [self.beckons objectAtIndex:indexPath.row];
    cell.textLabel.text = beckon.title;
    return cell;
}

- (NSMutableArray *)beckons{
    if(!_beckons){
        _beckons = [[NSMutableArray alloc] init];
    }
    return _beckons;
}

@end
