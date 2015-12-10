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
    var url = NSURL(string: "https://news.google.com/")!
    var displayedURL = NSURL(string: "https://blank.org/")!
    let urlStandard = NSURL(string: "https://blank.org/")!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.webView.scalesPageToFit = true
        self.webView.contentMode = UIViewContentMode.ScaleAspectFit
        
        self.userSearch.delegate = self
        updateDisplay()
    }
    
    func updateDisplay() -> Bool {
        //self.userSearch.delegate = self
        
        //update webView
        webView.loadRequest(NSURLRequest(URL: displayedURL))
        
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
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //if we click outside of the keyboard, the keyboard closes
        
        //NSLog("hello")
        self.view.endEditing(true) //true... force?
        
    }
    
    func textFieldShouldReturn( textField: UITextField ) -> Bool {
        //if we push return, we want the keyboard to close
        userSearch.resignFirstResponder()
        
        executeSearch()
        return true //completed successfully
    }
    
    func executeSearch() -> Bool {
        //runs when enter is pressed while editing search field
        let userInput = NSString(string: userSearch.text!)
        if (searchableContent.containsString(userInput as String) ) {
            //if what the user is trying to search for is found on
            //the code we get back from downloading data from
            //the news website, we try to find the url for it to display
            //print("found what the user is searching for!")
            //now we must find the url to the story that the user searched for so we can display it in the app
            
            //let charRange = searchableContent.rangeOfString(userInput as String)
            
            //let searchRange = NSMakeRange(charRange.location - 1000, 2000 )
            
            //print("\(userInput) found at index \(charRange.location) and is \(charRange.length) chars long")
            
            //let searchForURL: NSString = searchableContent.substringWithRange(searchRange)
            //var newURL: NSURL
            
            //if (searchForURL.containsString("url=")) {
            //aha. Found the URL
            //  let startofURL = searchableContent
            
            // newURL = NSURL(string: searchableContent.substringWithRange(urlRange))!
            //displayedURL = newURL
            //} else {
            // NSLog("could not find url...")
            //}
            displayedURL = NSURL(string: "https://memecrunch.com/meme/AFUA3/found-it/image.jpg?w=1024&c=1")!
            
            
        } else {
            print("could not find term")
            displayedURL = NSURL(string: "https://memecrunch.com/meme/AFUHX/i-checked-the-whole-backyard/image.jpg?w=425&c=1")!
            
        }
        
        
        if (updateDisplay() ) {
            //display updated correctly
            //NSLog("Display Correct")
        }
        return true
    }
    
    
}
