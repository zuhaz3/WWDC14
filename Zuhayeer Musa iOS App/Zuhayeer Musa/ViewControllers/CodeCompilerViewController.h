//
//  CodeCompilerViewController.h
//  Zuhayeer Musa
//
//  Created by Zuhayeer Musa on 4/10/14.
//  Copyright (c) 2014 Zuhayeer Musa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodeCompilerViewController : UIViewController<UIWebViewDelegate> {
    __weak IBOutlet UIWebView *webView;
}

@end
