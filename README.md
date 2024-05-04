# News-Aggregator-App
iOS application that allows users to browse news articles from various sources. It fetches data from the NewsAPI using the V1 legacy documentation. Users can view news sources, browse articles, read article details, and view articles in a web view. The app also includes settings to customize the theme.

## Features
- `Loading View`: Downloads news sources from the NewsAPI.
- `Sources View`: Displays news sources in a UITableView.
- `Articles View`: Shows news articles from selected sources.
- `Article Detail View`: Provides detailed information about selected articles.
- `Web View`: Opens articles in a web view for better readability.
- `Settings View`: Allows users to customize the app theme.

## Installation
To run the app locally, follow these steps:
1. Clone the repository to your local machine.
2. Open the project in Xcode.
3. Build and run the app on a simulator or device.
4. Ensure you have a valid NewsAPI key to fetch news data.

## Usage
- On launch, the app fetches news sources and displays them in the Sources View.
- Users can select a news source to view related articles in the Articles View.
- Tapping on an article opens the Article Detail View with additional information.
- The Web View allows users to read articles in a web browser.
- In the Settings View, users can choose from three themes and save their preference.

## Technologies Used
- **Swift**: The primary programming language used for iOS app development.
- **UIKit**: Provides the fundamental components for building iOS interfaces.
- **Foundation**: Provides a framework for working with data types, collections, and other essential utilities.
- **WebKit**: Used to display web content in the app's web view.
- **NewsAPI**: A RESTful API used to fetch news data for the app.
- **UserDefaults**: Used for storing user preferences, such as theme selection, across app sessions.

## Contributing
Contributions are welcome! 

### You can contribute by:
-  Reporting bugs
-  Suggesting new features
-  Submitting pull requests to improve the codebase
