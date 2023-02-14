//
//  TopViewController.swift
//  HackerNews
//
//  Created by Dimas Wisodewo on 28/01/23.
//

import UIKit

class ViewController: UITableViewController {
    var locals: (lastIndex: Int, updating: Bool) = (-1, false)
   
    var displayedStories = [Story]()
    var storyIds = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPrerequisites()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedStories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = displayedStories[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row >= locals.lastIndex && !locals.updating else { return }
        updateDisplayedData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = displayedStories[indexPath.row].url else { return }
        guard let link = URL(string: url) else { return }
        UIApplication.shared.open(link)
    }
}

extension ViewController {
    private func setupPrerequisites() {
        tableView.rowHeight = 80
        
        APICaller.shared.getTopStories {
            self.storyIds = $0
            self.updateDisplayedData()
        }
    }
    
    private func updateDisplayedData() {
        let maxIndex = (locals.lastIndex + 20) <= (storyIds.count - 1) ? (locals.lastIndex + 20) : (storyIds.count - 1)
        locals.updating = true
        
        for index in locals.lastIndex + 1 ... maxIndex {
            APICaller.shared.getStoryById(id: storyIds[index]) { story in
                self.displayedStories.append(story)
                
                DispatchQueue.main.async { [weak self] in
                    self?.updateTable(index: maxIndex)
                }
            }
        }
        
        locals.lastIndex = maxIndex
    }
    
    private func updateTable(index: Int) {
        guard displayedStories.count == index + 1 else { return }
        tableView.reloadData()
        locals.updating = false
    }
}
