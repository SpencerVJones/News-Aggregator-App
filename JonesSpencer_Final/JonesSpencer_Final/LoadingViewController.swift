//  LoadingViewController.swift
//  JonesSpencer_Final
//  Created by Spencer Jones on 4/28/24.

import UIKit

class LoadingViewController: UIViewController {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // Colors from theme
    var cellColor = UIColor.white
    var textColor = UIColor.black
    
    // Variables to store articles, sources, and filtered articles by source
    var articles = [Article]()
    var sources = [String]()
    var filteredArticlesBySource = [String: [Article]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Start animating activity indicator
        activityIndicator.startAnimating()
        
        // Load user defaults of theme colors
        if let savedColor = UserDefaults.standard.color(forKey: "cellColor") {
            cellColor = savedColor
        }
        
        if let savedColor = UserDefaults.standard.color(forKey: "textColor") {
            textColor = savedColor
        }
        
        // Parse JSON data
        DispatchQueue.global().async { [weak self] in
            self!.downloadJSON(atURL: "https://newsapi.org/v2/everything?q=keyword")
        }
    }
    
    
    func downloadJSON(atURL urlString: String) {
        // Create default configuration
        let config = URLSessionConfiguration.default
        // Create session
        let session = URLSession(configuration: config)
        // Validate URL to ensure it's not a broken link
        if let validURL = URL(string: urlString) {
            
            // Create request passing in vaildURL for header
            var request = URLRequest(url: validURL)
            // Set the header values
            request.setValue("22f90f55c3464258b66eeab2d822ac6b", forHTTPHeaderField: "X-API-Key")
            // Type of Request
            request.httpMethod = "GET"
            
            // Create task to send request and downlad data from vaildURL
            let task = session.dataTask(with: request, completionHandler: { (opt_data, opt_response, opt_error) in
                
                // Bail Out on error
                if opt_error != nil { return }
                
                // Check the response, statusCode, and data
                guard let response = opt_response as? HTTPURLResponse,
                      response.statusCode == 200,
                      let data = opt_data
                else {  return }
                
                do {
                    // De-Serialize data object
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        if let articles = json["articles"] as? [[String: Any]] {
                            // Iterate through each article
                            for article in articles {
                                // Extract information from article dictionary
                                if let author = article["author"] as? String,
                                   let content = article["content"] as? String,
                                   let description = article["description"] as? String,
                                   let publishedAt = article["publishedAt"] as? String,
                                   let source = article["source"] as? [String: Any],
                                   let sourceName = source["name"] as? String,
                                   let title = article["title"] as? String,
                                   let url = article["url"] as? String,
                                   let urlToImage = article["urlToImage"] as? String{
                                    
                                    // Map model object
                                    let articleArray = Article(author: author, content: content, description: description, publishedAt: publishedAt, sourceName: sourceName, title: title, url: url, UrlToImage: urlToImage)
                                    self.articles.append(articleArray)
                                }
                            }
                        }
                    }
                } catch { print(error.localizedDescription) }
                self.filterArticlesBySource()
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "segueToSource", sender: nil)
                }
            })
            // Start task
            task.resume()
        }
    }
    
    // Function to filter articles by source
    func filterArticlesBySource() {
        sources.removeAll()
        filteredArticlesBySource.removeAll()
        
        for article in articles {
            // Check if source name exists
            if !sources.contains(article.sourceName) {
                // If not add it
                sources.append(article.sourceName)
            }
            // Add article to corresponding source
            if var articlesForSource = filteredArticlesBySource[article.sourceName] {
                articlesForSource.append(article)
                filteredArticlesBySource[article.sourceName] = articlesForSource
            } else {
                filteredArticlesBySource[article.sourceName] = [article]
            }
        }
        // Sort sources
        sources.sort()
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let secondVC = segue.destination as? SourcesViewController {
            // Pass data to Sources View Controller
            secondVC.articles = self.articles
            secondVC.sources = self.sources
            secondVC.filteredArticlesBySource = self.filteredArticlesBySource
            
            secondVC.cellColor = self.cellColor
            secondVC.textColor = self.textColor
        }
    }
}
