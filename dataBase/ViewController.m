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

@end

@implementation ViewController

- (IBAction)saveDate:(id)sender {
    [self copyText];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    /*NSString* firstName = [self.firstName text];
    [[self firstName] resignFirstResponder];
    
    NSString* lastName = [self.lastName text];
    [[self lastName] resignFirstResponder];
    
    NSString* age = [self.age text];
    [[self age] resignFirstResponder];*/

    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
