//
//  SettingsVC.m
//  Junebug
//
//  Created by Steffen Rudkjøbing on 26/04/14.
//  Copyright (c) 2014 General Bits. All rights reserved.
//

#import "SettingsVC.h"
#import "AppDelegate.h"
#import "AppState.h"
#import "GradientLayers.h"
#import "SettingsCell.h"

@interface SettingsVC ()

@property (weak, nonatomic) IBOutlet UITableView *settingsTable;
@property (strong, nonatomic) NSArray *settingsArray;

@end

@implementation SettingsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.settingsArray = @[@"Friends", @"Groups"];
    self.settingsTable.dataSource = self;
    self.settingsTable.delegate = self;
    UIBarButtonItem *previousButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = previousButton;
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//Added row height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.settingsArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SettingsCell";
    SettingsCell *cell = (SettingsCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[SettingsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [self.settingsArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([[self.settingsArray objectAtIndex:indexPath.row] isEqualToString:@"Friends"]){
        [self performSegueWithIdentifier:@"settingsToFriends" sender:self];
    }
    else if([[self.settingsArray objectAtIndex:indexPath.row] isEqualToString:@"Groups"]){
        [self performSegueWithIdentifier:@"settingsToGroups" sender:self];
    }
    
    
}



@end
