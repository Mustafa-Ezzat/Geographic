//
//  WebViewController.swift
//  Gitex17
//
//  Created by Mustafa Ezzat on 10/1/17.
//  Copyright © 2017 Waqood. All rights reserved.
//

import UIKit

class WebViewController: BaseViewController {
    
    @IBOutlet weak var webView: UIWebView!
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.loadRequest(URLRequest(url: URL(string: url)!))
        webView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "bg.png"))
    }

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
