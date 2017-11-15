//
//  ShareObject.m
//  SwiftDemo01
//
//  Created by sunwf on 2017/4/12.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "ShareObject.h"

@interface  ShareObjectDelegateBradge : NSObject


@property (nonatomic,assign) id<ShareObjectDelegate>delegate;

@end


@implementation ShareObjectDelegateBradge



@end

@interface ShareObject()
{
    NSMutableArray * _delegates;
}
@end


@implementation ShareObject


+(ShareObject*)shareIncetance{
    
    static ShareObject * shareObject = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shareObject = [[ShareObject alloc]init];
        
    });
    
    return shareObject;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
     
        _delegates = [NSMutableArray array];
    }
    return self;
}


-(void)addDelegate:(id<ShareObjectDelegate>)delegate
{
    ShareObjectDelegateBradge * bradge = [[ShareObjectDelegateBradge alloc]init];
    bradge.delegate = delegate;
    [_delegates addObject:bradge];
}

-(void)removeDelegate:(id<ShareObjectDelegate>)delegate
{
    for (ShareObjectDelegateBradge * bradge in _delegates) {
        
        if (bradge.delegate == delegate) {
            
            bradge.delegate = nil;
            [_delegates removeObject:bradge];
        }
        
    }
    
}


-(void)sayHelloToTheDelegate{
    
    for (ShareObjectDelegateBradge * bradge in _delegates) {
        
        if ([bradge.delegate respondsToSelector:@selector(doSomeThingForEveryone)]) {
            [bradge.delegate doSomeThingForEveryone];
        }
    }
    
}


@end
