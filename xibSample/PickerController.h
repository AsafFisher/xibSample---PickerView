//
//  PickerController.h
//  xibSample
//
//  Created by Asaf Fisher on 6/15/14.
//  Copyright (c) 2014 Asaf Fisher. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kAnimationDuration 0.3
typedef enum : NSInteger{
    PickerControllerTypeBirthdate,
    PickerControllerTypeGender,
    PickerControllerTypeOccupation
}PickerControllerType;
@class PickerController;
@protocol PickerControllerDelegate <NSObject>

- (void) pickerController:(PickerController *)controller finishedWithResult:(id)result;
- (void) didCancelPickerController:(PickerController *)controller;
-(void)pickerController:(PickerController *)controller valueChanged:(id)newVal;

@end

@interface PickerController : NSObject


@property (nonatomic,assign,readonly)PickerControllerType pickerConteollerType;
@property(nonatomic,strong)IBOutlet id <PickerControllerDelegate>delegate;
- (void)showOnView:(UIView *)view withType:(PickerControllerType)type;

@end
