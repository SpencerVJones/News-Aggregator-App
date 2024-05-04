//  WebViewController.swift
//  JonesSpencer_Final
//  Created by Spencer Jones on 4/28/24.

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    // Outlets
    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var navBarTitle: UINavigationItem!
    @IBOutlet var webView: WKWebView!
    @IBOutlet var background: UIView!
    
    // Colors from theme
    var cellColor: UIColor?
    var textColor: UIColor?
    
    // Variable to hold the selected article
    var selectedArticle: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set title label to selected article's source
        navBarTitle.title = selectedArticle?.sourceName
        
        // Set colors with color data
        navBar.backgroundColor = cellColor
        background.backgroundColor = cellColor
        
        // Load URL of selected article into WKWebView
        if let urlString = selectedArticle?.url, let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        } else { print("Invalid URL") }
    }
    
    
    // MARK: - Navigation
    @IBAction func backButtonTapped(_ sender: UIButton) {
        // Dismiss view controller when back button tapped
        dismiss(animated: true)
    }
}
