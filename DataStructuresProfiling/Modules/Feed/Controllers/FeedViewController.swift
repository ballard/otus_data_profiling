//
//  FeedViewController.swift
//  OTUS
//
//  Created by Дмитрий Матвеенко on 01/06/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let feedData = Services.feedProvider.feedMockData()
    
    private var filteredFeedData = [FeedData]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var feedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
    }
}

extension FeedViewController: UITableViewDataSource {
    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard isFiltering else {
            return feedData.count
        }
        return filteredFeedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedTableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.reuseID, for: indexPath) as? FeedTableViewCell
        guard let feedCell = cell else { return UITableViewCell() }
        
        var name = ""
        
        if isFiltering {
            name = filteredFeedData[indexPath.row].name
        } else {
            name = feedData[indexPath.row].name
        }
        
        feedCell.updateCell(name: name)
        return feedCell
    }
}

extension FeedViewController: UITableViewDelegate {
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var vc: UIViewController?
        
        if let currentCell = tableView.cellForRow(at: indexPath) as? FeedTableViewCell, let name = currentCell.nameLabel.text {
            switch name {
            case "Array":
                let storyboard = UIStoryboard(name: "DataStructures", bundle: nil)
                vc = storyboard.instantiateViewController(withIdentifier: "ArrayViewController")
            case "Set":
                let storyboard = UIStoryboard(name: "DataStructures", bundle: nil)
                vc = storyboard.instantiateViewController(withIdentifier: "SetViewController")
            case "Dictionary":
                let storyboard = UIStoryboard(name: "DataStructures", bundle: nil)
                vc = storyboard.instantiateViewController(withIdentifier: "DictionaryViewController")
            case "SuffixArray":
                let storyboard = UIStoryboard(name: "DataStructures", bundle: nil)
                vc = storyboard.instantiateViewController(withIdentifier: "SuffixArrayViewController")
            default:
                let storyboard = UIStoryboard(name: "Feed", bundle: nil)
                vc = storyboard.instantiateViewController(withIdentifier: "SessionSummaryViewController")
            }
        }
        
        
        if let pushViewController = vc {
            self.navigationController?.pushViewController(pushViewController, animated: true)
        }
    }
}

// MARK: - Searching

extension FeedViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("updating search results")
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    func setupSearchController() {
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search Candies"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
    }
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredFeedData = feedData.filter { (feed: FeedData) -> Bool in
            return feed.name.lowercased().contains(searchText.lowercased())
        }
        
        feedTableView.reloadData()
    }
}


