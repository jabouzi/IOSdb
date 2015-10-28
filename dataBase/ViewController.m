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

@end

@implementation ViewController

- (IBAction)saveDate:(id)sender {
    [self copyText];
    [self.view endEditing:YES];
}
- (IBAction)createDB:(id)sender {
    
    [self.view endEditing:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"users.db"];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self copyText];
    [textField resignFirstResponder];
    return YES;
}

-(void)copyText
{
    NSString* firstName = [self.firstName text];
    [[self firstName] resignFirstResponder];
    
    NSString* lastName = [self.lastName text];
    [[self lastName] resignFirstResponder];
    
    NSString* age = [self.age text];
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

    
    query = @"select * from users";
    NSLog(@"%@", [self.dbManager loadDataFromDB:query]);
    self.dbDump.text = [NSString stringWithFormat:@"%@", [self.dbManager loadDataFromDB:query]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
