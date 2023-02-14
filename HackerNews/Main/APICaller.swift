//
//  APICaller.swift
//  HackerNews
//
//  Created by Dimas Wisodewo on 28/01/23.
//

import Foundation

class APICaller {
    static let shared = APICaller()
    
    func getTopStories(completion: @escaping ([Int]) -> Void) {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let safeData = data, error == nil else { return }
            let results = try? JSONDecoder().decode([Int].self, from: safeData)
            completion(results ?? [])
        }
        
        task.resume()
    }
    
    func getStoryById(id: Int, completion: @escaping (Story) -> Void) {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let safeData = data, error == nil else { return }
            let results = try? JSONDecoder().decode(Story.self, from: safeData)
            completion(results ?? Story(id: 0, score: 0, title: "", url: nil))
        }
        
        task.resume()
    }
}
