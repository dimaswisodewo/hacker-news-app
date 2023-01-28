//
//  ShowViewController.swift
//  HackerNews
//
//  Created by Dimas Wisodewo on 28/01/23.
//

import UIKit

class ShowViewController: UIViewController {

    var storyIds: [Int] = []
    var displayedStories: [Story] = []
    
    let limit = 20
    var lastItemIndex = -1
    var isUpdating = false
    
    // Create table view
    private let showTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        view.addSubview(showTable)
        
        // Set table views delegate & data source
        showTable.delegate = self
        showTable.dataSource = self
        
        fetchShowStories()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        showTable.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Set to large title
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Show Stories"
        self.navigationController?.navigationBar.sizeToFit()
    }
    
    // Fetch show stories data
    private func fetchShowStories() {
        APICaller.shared.getShowStories { showStoryResponse in
            self.storyIds = showStoryResponse
            // Get story data until item limit is reached
            self.updateDisplayedData()
        }
    }
    
    // Get story data and update to UI
    private func updateDisplayedData() {
        print("UpdateDisplayedData")
        // Get max index
        let maxIndex = (lastItemIndex + limit) <= storyIds.count ? (lastItemIndex + limit) : (storyIds.count - 1)
        
        isUpdating = true
        
        // Fetch API
        for i in lastItemIndex+1...maxIndex {
            print("get data ke-\(i)")
            // Get story data by id and add it inside stories array
            APICaller.shared.getStoryById(id: storyIds[i]) { story in
                self.displayedStories.append(story)
                // Reload table view in main thread
                DispatchQueue.main.async { [weak self] in
                    self?.showTable.reloadData()
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

extension ShowViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayedStories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
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
