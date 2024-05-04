//  ArticleDetailViewController.swift
//  JonesSpencer_Final
//  Created by Spencer Jones on 4/28/24.
//  Default article image is from https://www.freepik.com/

import UIKit

class ArticleDetailViewController: UIViewController {
    
    // Outlets
    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var navBarTitle: UINavigationItem!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var descTextView: UITextView!
    @IBOutlet var background: UIView!
    
    // Colors from theme
    var cellColor: UIColor?
    var textColor: UIColor?
    
    // Variable to hold the selected article
    var selectedArticle: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageUrlString = selectedArticle?.UrlToImage
        
        // Check if URL is valid
        guard let imageUrl = URL(string: imageUrlString!) else {
            print("Invalid image URL")
            return
        }
        
        // Create URLSession data task to download image
        let task = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            // Check for error
            if error != nil { return }
            // Check if data received
            guard let imageData = data else { return }
            
            // Create UIImage from downloaded data
            if let image = UIImage(data: imageData) {
                
                // Update UI
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
        // Start task
        task.resume()
        
        // Set text with article data
        titleLabel.text = selectedArticle?.title
        authorLabel.text = selectedArticle?.formattedAuthor
        dateLabel.text = selectedArticle?.formattedPublishedDate()
        descTextView.text = selectedArticle?.description
        navBarTitle.title = selectedArticle?.sourceName
        
        // Set colors with color data
        titleLabel.textColor = textColor
        authorLabel.textColor = textColor
        dateLabel.textColor = textColor
        descTextView.textColor = textColor
        navBar.backgroundColor = cellColor
        descTextView.backgroundColor = cellColor
        background.backgroundColor = cellColor
    }
    
    // MARK: - Navigation
    @IBAction func backButtonTapped(_ sender: UIButton) {
        // Dismiss view controller when back button tapped
        dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let fifthVC = segue.destination as? WebViewController {
            // Pass data to Web View Controller
            fifthVC.selectedArticle = self.selectedArticle
            fifthVC.cellColor = self.cellColor
            fifthVC.textColor = self.textColor
        }
    }
}
