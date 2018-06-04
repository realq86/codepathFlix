//
//  WebViewControllerSwift.swift
//  Flix
//
//  Created by Chi Hwa Michael Ting on 6/3/18.
//  Copyright © 2018 CodePath. All rights reserved.
//

import UIKit
import WebKit

class WebViewControllerSwift: UIViewController {

    
    @IBOutlet var webkitView: WKWebView!
    
    // MARK: #1 Code snippet for : https://github.com/codepath/ios_guides/wiki/Using-WebKit-View
    
    //**Above** the `viewDidLoad` method, create a constant to hold your URL string. We will link to the DropBox mobile terms url.
    let url = "https://www.dropbox.com/terms?mobile=1"
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Convert the url String to a NSURL object.
        let requestURL = URL(string:url)
        // Place the URL in a URL Request.
        let request = URLRequest(url: requestURL!)
        webkitView.load(request)
        
        
    }

    // MARK: #1 END
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
