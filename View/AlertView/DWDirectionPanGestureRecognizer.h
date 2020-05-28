//
//  DWDirectionPanGestureRecognizer.h
//  DWslideViewDemo
//
//  Created by dangwc on 2018/1/9.
//  Copyright © 2018年 dangwc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

typedef enum {
    DWDirectionPangestureRecognizerVertical,
    DWDirectionPanGestureRecognizerHorizontal
} DWDirectionPangestureRecognizerDirection;

@interface DWDirectionPanGestureRecognizer : UIPanGestureRecognizer{
    BOOL _drag;
    int _moveX;
    int _moveY;
    DWDirectionPangestureRecognizerDirection _direction;
}


@property (nonatomic, assign) DWDirectionPangestureRecognizerDirection direction;

@end
