//
//  ViewController.m
//  xibSample
//
//  Created by Asaf Fisher on 6/15/14.
//  Copyright (c) 2014 Asaf Fisher. All rights reserved.
//

#import "ViewController.h"
#import "PickerController.h"
@interface ViewController ()<PickerControllerDelegate>

@end

@implementation ViewController
@synthesize pickerController;
- (IBAction)selectBirthDateAction:(id)sender {
    
[pickerController showOnView:self.view withType:PickerControllerTypeBirthdate];
}
- (IBAction)selectGenderAction:(id)sender {
    [pickerController showOnView:self.view withType:PickerControllerTypeGender];
}
- (IBAction)selectOccupationAction:(id)sender {
    [pickerController showOnView:self.view withType:PickerControllerTypeOccupation];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) pickerController:(PickerController *)controller finishedWithResult:(id)result{
    NSLog(@"%@",result);
    
}
- (void) didCancelPickerController:(PickerController *)controller{
    NSLog(@"%@",controller);
    
}
-(void)pickerController:(PickerController *)controller valueChanged:(id)newVal{
    NSLog(@"%@",newVal);
}
@end
