//  ArticlesViewController.swift
//  JonesSpencer_Final
//  Created by Spencer Jones on 4/28/24.
//  Default article image is from https://www.freepik.com/

import UIKit

// Global private constant for resuse id
private let articlesCell = "articlesCell"

class ArticlesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Outlets
    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var navBarTitle: UINavigationItem!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var background: UIView!
    
    // Colors from theme
    var cellColor = UIColor.white
    var textColor = UIColor.black
    
    // Variables to store articles and filtered articles by source
    var articles = [Article]()
    var filteredArticles = [Article]()
    
    // Variables to to store selected source and selected article
    var selectedSource: String?
    var selectedArticle: Article?
    
    override func viewDidLoad() {
        
        // If source selected, filter articles based on source
        if let source = selectedSource {
            filteredArticles = articles.filter { $0.sourceName == source }
        }
        
        // Set title of navigation bar to selected source
        navBarTitle.title = selectedSource
        
        // Set background color of table view, navigation bar, and background view
        tableView.backgroundColor = cellColor
        navBar.backgroundColor = cellColor
        background.backgroundColor = cellColor
        
        // Reload table view
        tableView.reloadData()
    }
    
    
    // MARK: Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArticles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue reusable cell with identifier "articlesCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: articlesCell, for: indexPath) as? ArticlesTableViewCell else {
            // If cell is not of type ArticlesTableViewCell, return default cell
            return tableView.dequeueReusableCell(withIdentifier: articlesCell, for: indexPath)
        }
        
        // Get article at current index path
        let article = filteredArticles[indexPath.row]
        
        // Set article title label text
        cell.articleTitleLabel.text = article.title
        
        // Download and set article image if URL is available
        let imageUrlString = article.UrlToImage
        let imageUrl = URL(string: imageUrlString)!
        // Create URLSession data task to download image
        let task = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            // Check for errors
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                return
            }
            
            // Check if data received
            guard let imageData = data, let image = UIImage(data: imageData) else {
                print("Failed to create UIImage from data")
                return
            }
            
            // Update UI on main thread
            DispatchQueue.main.async {
                cell.cellImageView.image = image
            }
        }
        // Start task
        task.resume()
        
        // Set background color and text color of cell
        cell.backgroundColor = cellColor
        cell.articleTitleLabel.textColor = textColor
        
        return cell
    }
    
    // Set height of cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get selected article
        let selectedArticle = filteredArticles[indexPath.row]
        self.selectedArticle = selectedArticle
        
        performSegue(withIdentifier: "segueToDetail", sender: nil)
    }
    
    // MARK: - Navigation
    @IBAction func BackButtonTapped(_ sender: UIButton) {
        // Dismiss view controller when back button tapped
        dismiss(animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let fourthVC = segue.destination as? ArticleDetailViewController {
            // Pass data to Article Detail View Controller
            fourthVC.selectedArticle = self.selectedArticle
            fourthVC.cellColor = self.cellColor
            fourthVC.textColor = self.textColor
        }
    }
}
