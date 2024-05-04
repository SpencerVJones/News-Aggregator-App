//  SettingsViewController.swift
//  JonesSpencer_Final
//  Created by Spencer Jones on 4/28/24.

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var peviewLabel: UILabel!
    @IBOutlet var colorView: UIView!
    
    // Colors from theme
    var cellColor: UIColor?
    var textColor: UIColor?
    
    // Arrays to store theme colors
    var cellColors: [UIColor] = []
    var textColors: [UIColor] = []
    
    // Custom color
    let lightOrangeColor = UIColor(red: 0.9882, green: 0.9529, blue: 0.8706, alpha: 1.0)
    
    // Variables to store articles, sources, and filtered articles by source
    var articles = [Article]()
    var sources = [String]()
    var filteredArticlesBySource = [String: [Article]]()
    
    // Variable to store selected index path
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initalizing theme colors
        cellColors = [.white, .black, lightOrangeColor, .darkGray]
        textColors = [.black, .white, .black, .white]
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        
        // Set cell text and colors
        cell.textLabel?.text = "Theme \(indexPath.row + 1)"
        cell.textLabel?.textColor = textColors[indexPath.row]
        cell.backgroundColor = cellColors[indexPath.row]
        
        // Highlight selected cell
        if indexPath == selectedIndexPath {
            cell.accessoryType = .checkmark
        } else { cell.accessoryType = .none }
        
        return cell
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
        // Save selected colors
        cellColor = cellColors[indexPath.row]
        textColor = textColors[indexPath.row]
        
        // Update preview label and colors
        peviewLabel.text = "Selected Theme \(indexPath.row + 1)"
        colorView.backgroundColor = cellColor
        peviewLabel.textColor = textColor
        
        // Reload table view
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        // Reset theme to orginal theme
        cellColor = .white
        textColor = .black
        
        // Update preview label and colors
        peviewLabel.text = "Selected Theme 1"
        peviewLabel.textColor = .black
        colorView.backgroundColor = .white
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        //  Save User Defaults when save button tapped
        UserDefaults.standard.set(color: cellColor!, forKey: "cellColor")
        UserDefaults.standard.set(color: textColor!, forKey: "textColor")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let secondVC = segue.destination as? SourcesViewController {
            // Pass data to Sources View Controller
            secondVC.cellColor = self.cellColor!
            secondVC.textColor = self.textColor!
            
            secondVC.sources = self.sources
            secondVC.articles = self.articles
            secondVC.filteredArticlesBySource = self.filteredArticlesBySource
        }
    }
}
