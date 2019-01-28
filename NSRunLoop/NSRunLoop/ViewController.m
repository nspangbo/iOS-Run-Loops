//
//  ViewController.m
//  NSRunLoop
//
//  Created by Bo Wang on 2019/1/8.
//  Copyright © 2019 Bo Wang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSTimer *t1;
@property (nonatomic, strong) NSTimer *t2;
@property (nonatomic, strong) NSTimer *t3;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"viewDidLoad ...");
    dispatch_queue_t queue = dispatch_queue_create("test queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSRunLoop *rl = [NSRunLoop currentRunLoop];
        //NSRunLoop *mainRL = [NSRunLoop mainRunLoop];
        
        self.t1 = [NSTimer timerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"timer1 fire ...");
        }];
        
        self.t2 = [NSTimer timerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"timer2 fire ...");
        }];
        
        self.t3 = [NSTimer timerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"timer3 fire ...");
        }];
        
        [rl addTimer:self.t1 forMode:NSDefaultRunLoopMode];
        [rl addTimer:self.t2 forMode:NSDefaultRunLoopMode];
        
        // TODO: 为什么需要在启动 RunLoop 之前加入？？？
        [rl performSelector:@selector(hello) target:self argument:nil order:100 modes:@[NSDefaultRunLoopMode]];
        
        // TODO: 为什么需要在启动 RunLoop 之前加入？？？
        [rl performBlock:^{
            NSLog(@"performBlock");
        }];
        
        [rl run]; // RunLoop 永久执行
        
        // TODO: 为什么启动 RunLoop 之后加入无效？？？
        [rl addTimer:self.t3 forMode:NSDefaultRunLoopMode];
        
        // NSDate *fireDate = [rl limitDateForMode:NSDefaultRunLoopMode]; // 并没有执行一次？？？
        // NSLog(@"%@", fireDate);
        
        // [rl runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:3]]; // 3s 内执行一次
        
        //[rl runUntilDate:[NSDate dateWithTimeIntervalSinceNow:5]]; // 5s 内持续执行
        
        //[rl acceptInputForMode:UITrackingRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:5]]; // 5s 内在特定模式中持续执行
    });
    
}

- (void)hello {
    NSLog(@"hello ...");
}


@end
