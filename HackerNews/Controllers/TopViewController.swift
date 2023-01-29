//
//  TopViewController.swift
//  HackerNews
//
//  Created by Dimas Wisodewo on 28/01/23.
//

import UIKit

class TopViewController: UIViewController {

    var storyIds: [Int] = []
    var displayedStories: [Story] = []
    
    let limit = 20
    var lastItemIndex = -1
    var isUpdating = false
    
    // Create table view
    private let topTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        view.addSubview(topTable)
        
        // Set table views delegate & data source
        topTable.delegate = self
        topTable.dataSource = self
        
        fetchTopStories()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topTable.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Set to large title
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "New and Top Stories"
        self.navigationController?.navigationBar.sizeToFit()
        
        // Show tab bar
        tabBarController?.tabBar.isHidden = false
    }
    
    // Fetch top stories data
    private func fetchTopStories() {
        APICaller.shared.getTopStories { topStoryResponse in
            self.storyIds = topStoryResponse
            // Get story data until item limit is reached
            self.updateDisplayedData()
        }
    }
    
    // Get story data and update to UI
    private func updateDisplayedData() {
        print("UpdateDisplayedData")
        // Get max index
        let maxIndex = (lastItemIndex + limit) <= (storyIds.count - 1) ? (lastItemIndex + limit) : (storyIds.count - 1)
        
        isUpdating = true
        
        // Fetch API
        for i in lastItemIndex+1...maxIndex {
            print("get data ke-\(i)")
            // Get story data by id and add it inside stories array
            APICaller.shared.getStoryById(id: storyIds[i]) { story in
                self.displayedStories.append(story)
                // Reload table view in main thread
                DispatchQueue.main.async { [weak self] in
                    self?.topTable.reloadData()
                    if i == maxIndex {
                        self?.isUpdating = false
                    }
                }
            }
        }
        // Update last item index
        lastItemIndex = maxIndex
    }
}

extension TopViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayedStories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.text = displayedStories[indexPath.row].title
        return cell
    }
    
    // Update displayed data when reaching the last item
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row >= lastItemIndex && !isUpdating) {
            updateDisplayedData()
        }
    }
    
    // On select item
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Disable highlight
        tableView.deselectRow(at: indexPath, animated: true)
        // Open webview if the url exist
        guard let safeUrl = displayedStories[indexPath.row].url else { return }
        let webView = DetailViewController()
        webView.url = safeUrl
        navigationController?.pushViewController(webView, animated: true)
    }
    
    // Row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
