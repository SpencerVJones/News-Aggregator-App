//  Article.swift
//  JonesSpencer_Final
//  Created by Spencer Jones on 4/28/24.

import Foundation

class Article {
    let author: String
    let content: String
    let description: String
    let publishedAt: String
    var sourceName: String
    let title: String
    let url: String
    let UrlToImage: String
    
    // Computed property to format author in UI
    var formattedAuthor: String {
        let authorString = "By \(author)"
        return authorString
    }
    
    
    // Initalizer
    init(author: String, content: String, description: String, publishedAt: String, sourceName: String, title: String, url: String, UrlToImage: String) {
        self.author = author
        self.content = content
        self.description = description
        self.publishedAt = publishedAt
        self.sourceName = sourceName
        self.title = title
        self.url = url
        self.UrlToImage = UrlToImage
    }
    
    func formattedPublishedDate() -> String {
        // Create date formatter
        let dateFormatter = DateFormatter()
        // Set input format
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        // Convert publishedAt string to Date object
        guard let date = dateFormatter.date(from: publishedAt) else {
            return "Invalid date format"
        }
        // Set output format
        dateFormatter.dateFormat = "MMMM dd, yyyy hh:mm a"
        // Convert date object to formatted string
        return "Published " + dateFormatter.string(from: date)
    }
}
