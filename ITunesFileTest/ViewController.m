//
//  ViewController.m
//  ITunesFileTest
//
//  Created by LHL on 16/1/14.
//  Copyright © 2016年 LHL. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIDocumentInteractionControllerDelegate>
@property (nonatomic, strong) UIDocumentInteractionController *documentController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)buttonClicked:(id)sender {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths firstObject];
    NSString *cachePath = nil;
    NSFileManager *manager = [NSFileManager defaultManager] ;
    if (![manager fileExistsAtPath:documentPath]) {
        NSLog(@"没有文件");
    }else {
        NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:documentPath  ] objectEnumerator];
        NSString *fileName = nil;
        while ((fileName = [childFilesEnumerator nextObject]) != nil ){
            NSString* fileAbsolutePath = [documentPath stringByAppendingPathComponent:fileName];
            BOOL isDirectory = NO;
            NSLog(@"filePath %@", fileName);
            cachePath = [NSString stringWithFormat:@"%@/%@",documentPath, fileName];
            if ([manager fileExistsAtPath:fileAbsolutePath isDirectory:&isDirectory]){
                NSDictionary *dic =  [manager attributesOfItemAtPath:fileAbsolutePath error:nil] ;
                NSLog(@"%@", dic);
            }
            break;
        }
    }
    
    if (nil == cachePath) {
        NSLog(@"cachePath 不能为nil");
        return;
    }
    
    self.documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:cachePath]];
    self.documentController.delegate = self;
    [self.documentController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
}


-(void)documentInteractionController:(UIDocumentInteractionController *)controller  willBeginSendingToApplication:(NSString *)application{
    
    
}


-(void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application{
    
}


-(void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
