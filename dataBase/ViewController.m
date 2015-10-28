//
//  ViewController.m
//  dataBase
//
//  Created by Skander Jabouzi on 2015-10-24.
//  Copyright © 2015 Skander Software Solutions. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextView *dbDump;
@property (weak, nonatomic) IBOutlet UITextField *user_id;

@end

@implementation ViewController

- (IBAction)saveData:(id)sender {
    [self saveUserData];
    [self.view endEditing:YES];
}

- (IBAction)getUser:(id)sender {
    [self searchUserById];
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"users.db"];
    NSString *query = @"select * from users";
    NSLog(@"%@", [self.dbManager loadDataFromDB:query]);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self saveUserData];
    [textField resignFirstResponder];
    return YES;
}

-(void)saveUserData
{
    NSString* firstName = [[self.firstName text] stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
    [[self firstName] resignFirstResponder];
    
    NSString* lastName = [[self.lastName text] stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
    [[self lastName] resignFirstResponder];
    
    NSString* age = [[self.age text] stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
    [[self age] resignFirstResponder];
    
    NSString *query = [NSString stringWithFormat:@"insert into users (firstname, lastname, age) values ('%@','%@', '%@');",firstName, lastName, age];
    
    NSLog(@"%@", query);
    
    [self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
    }
    else{
        NSLog(@"Could not execute the query.");
    }
}

- (void)searchUserById
{
    NSString* user_id = [[self.user_id text] stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
    [[self firstName] resignFirstResponder];
    
    if ([user_id length] > 0)
    {
        NSString *query = [NSString stringWithFormat:@"select * from users where id = '%@';", user_id];
        NSLog(@"%@", query);
        NSArray *results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
        if ([results count] > 0)
        {
            self.firstName.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"firstname"]];
            self.lastName.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"lastname"]];
            self.age.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"age"]];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
