//
//  ViewController.swift
//  NewsGetter
//
//  Created by Logan Whitmire on 12/9/15.
//  Copyright © 2015 Logan Whitmire. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var userSearch: UITextField!
    @IBOutlet var webView: UIWebView!
    var searchableContent: NSString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let url = NSURL(string: "https://news.google.com/")!
        let urlStandard = NSURL(string: "https://blank.org/")!
        
        self.userSearch.delegate = self
        
        //blank view when we first load app
        webView.loadRequest(NSURLRequest(URL: urlStandard))
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            //executes when task completes
            
            if let urlContent = data {
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                //print(webContent)
                self.searchableContent = webContent!
            } else {
                //show error message
                NSLog("Could not find web content")
                
            }
         }
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //if we click outside of the keyboard, the keyboard closes
        
        NSLog("hello")
        self.view.endEditing(true) //true... force?
        
    }
    
    func textFieldShouldReturn( textField: UITextField ) -> Bool {
        //if we push return, we want the keyboard to close
        userSearch.resignFirstResponder()
        
        executeSearch()
        return true //completed successfully
    }
    
    func executeSearch() -> Bool {
        print("enter rec.")
        NSLog("enter recognized")
        //runs when enter is pressed while editing search field
        let userInput = NSString(string: userSearch.text!)
        if (searchableContent.containsString(userInput as String) ) {
            //if what the user is trying to search for is found on
            //the code we get back from downloading data from
            //the news website, we try to find the url for it to display
            print("found what the user is searching for!")
        } else {
            print("could not find term")
        }
        
        
        
        return true
    }


}

