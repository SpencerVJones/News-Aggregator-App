//  SourcesViewController.swift
//  JonesSpencer_Final
//  Created by Spencer Jones on 4/28/24.

import UIKit

// Global private constant for resuse id
private let sourceCell = "sourcesCell"

class SourcesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Outlets
    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var navBarTitle: UINavigationItem!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var toolBar: UIToolbar!
    @IBOutlet var background: UIView!
    
    // Colors from theme
    var cellColor = UIColor.white
    var textColor = UIColor.black
    
    // Variables to store articles, sources, and filtered articles by source
    var articles = [Article]()
    var sources = [String]()
    var filteredArticlesBySource = [String: [Article]]()
    
    // Variable to store selected source
    var selectedSource: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set background color of table view, navigation bar, toolbar, and background view
        tableView.backgroundColor = cellColor
        navBar.backgroundColor = cellColor
        toolBar.barTintColor = cellColor
        background.backgroundColor = cellColor
    }
    
    
    // MARK: Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue reusable cell with identifier "sourcesCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: sourceCell, for: indexPath) as? SourcesTableViewCell else {
            // If cell is not of type SourcesTableViewCell, return default cell
            return tableView.dequeueReusableCell(withIdentifier: sourceCell, for: indexPath)
        }
        
        // Set text of source name label to source at current index path
        cell.sourceNameLabel.text = sources[indexPath.row]
        
        // Set background color and text color of  cell
        cell.backgroundColor = cellColor
        cell.sourceNameLabel.textColor = textColor
        
        return cell
    }
    
    
    // MARK: Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Set selected source to source at current index path
        selectedSource = sources[indexPath.row]
        
        performSegue(withIdentifier: "segueToArticlesView", sender: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let thirdVC = segue.destination as? ArticlesViewController {
            // Pass data to Articles View Controller
            thirdVC.articles = self.articles
            thirdVC.selectedSource = self.selectedSource
            
            thirdVC.cellColor = self.cellColor
            thirdVC.textColor = self.textColor
        }
        
        if let thirdVC = segue.destination as? SettingsViewController {
            // Pass data to Settings View Controller
            thirdVC.sources = self.sources
            thirdVC.articles = self.articles
            
            thirdVC.cellColor = self.cellColor
            thirdVC.textColor = self.textColor
        }
    }
}
