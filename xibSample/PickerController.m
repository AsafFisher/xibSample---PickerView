//
//  PickerController.m
//  xibSample
//
//  Created by Asaf Fisher on 6/15/14.
//  Copyright (c) 2014 Asaf Fisher. All rights reserved.
//

#import "PickerController.h"
@interface PickerController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *contentPickerView;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong)NSArray *pickerArray;

@end
@implementation PickerController
@synthesize delegate,datePicker,contentPickerView,mainView,bgView,pickerArray;
//Present the UI from the xib file
- (void)showOnView:(UIView *)view withType:(PickerControllerType)type{
    //In case of inheritance, make sure that your xib named exactly as your subclass name
# warning class name must have the same name of your nib file!
    [self showOnView:view withType:type optionalNibName:@"PickerController"];
  
    
}
//done Action
- (IBAction)doneAction:(id)sender {
    if ([delegate respondsToSelector:@selector(pickerController:finishedWithResult:)]){
        id value = nil;
        switch (_pickerConteollerType){
            case PickerControllerTypeBirthdate:
                datePicker.hidden = NO;
                contentPickerView.hidden = YES;
                value = [datePicker date];
                break;
            case PickerControllerTypeGender:
            case PickerControllerTypeOccupation:{
                NSInteger row = [contentPickerView selectedRowInComponent:0];
                value = pickerArray[row];
            }
                break;
        }
        [delegate pickerController:self finishedWithResult:value];
    }
    [self removeAction];
    
}
//cancel Action
- (IBAction)cancelAction:(id)sender {
    if ([delegate respondsToSelector:@selector(didCancelPickerController:)]){
        [delegate didCancelPickerController:self];
    }
    [self removeAction];
}

//removes all the views + dealloc them + animation
-(void)removeAction{
    [UIView animateWithDuration:kAnimationDuration animations:^{
        bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [mainView removeFromSuperview];
        [bgView removeFromSuperview];
        self.bgView = nil;
        self.pickerArray = nil;
        self.mainView = nil;
    }];
    }

// send to the pickerController delegate method the date picker date value.

- (IBAction)datePickerValueChangedAction:(UIDatePicker *)sender {
    if([delegate respondsToSelector:@selector(pickerController:valueChanged:)]){
        [delegate pickerController:self valueChanged:datePicker.date];
        
    }
}

//configur the UI by the picker controller type that was chosed.

-(void)configureUI{
    switch (_pickerConteollerType){
        case PickerControllerTypeBirthdate:
            datePicker.hidden = NO;
            contentPickerView.hidden = YES;
            break;
        case PickerControllerTypeGender:
            contentPickerView.hidden = NO;
            datePicker.hidden = YES;
            self.pickerArray = @[@"None",@"Male",@"Female"];
            [contentPickerView reloadAllComponents];
            break;
        case PickerControllerTypeOccupation:
            contentPickerView.hidden = NO;
            datePicker.hidden = YES;
            self.pickerArray = @[@"A",@"B",@"C",@"D"];
            [contentPickerView reloadAllComponents];
            break;
        default:
            break;
    }
}

//make this class the owner of the xib file + customisation of the mainView and the bgView +add the bg view to the view that was sended it the msg.
- (void)showOnView:(UIView *)view withType:(PickerControllerType)type optionalNibName:(NSString *)nibName{
    if([mainView superview] == nil)
    {
        
        _pickerConteollerType = type;
        UINib *nib = [UINib nibWithNibName:nibName bundle:[NSBundle mainBundle]];
        [nib instantiateWithOwner:self options:nil];
        bgView = [[UIView alloc]initWithFrame:view.bounds];
        bgView.backgroundColor = [UIColor blackColor];
   
        bgView.alpha = 0;
         UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeAction)];
        [bgView addGestureRecognizer:tap];
        [bgView addSubview:mainView];
        mainView.layer.masksToBounds = YES;
        mainView.layer.cornerRadius = 20 ;
        mainView.center = bgView.center;
        [view addSubview:bgView];
        
        // animate the view showUp
        [UIView animateWithDuration:kAnimationDuration animations:^{
            bgView.alpha = 0.65;
        }];
    }
    
    [self configureUI];
   
}




#pragma mark - UIPickerView Data src
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerArray count];
}
#pragma mark - UIPickerView Delegate Methods
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return pickerArray[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if ([delegate respondsToSelector:@selector(pickerController:valueChanged:)]){
        [delegate pickerController:self valueChanged:pickerArray[row]];
    }
    
}
@end
