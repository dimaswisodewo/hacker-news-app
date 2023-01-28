//
//  APICaller.swift
//  HackerNews
//
//  Created by Dimas Wisodewo on 28/01/23.
//

import Foundation

struct Constants {
    static let baseURL = "https://hacker-news.firebaseio.com/v0"
}

class APICaller {
    
    // Create a singleton
    static let shared = APICaller()
    
    // Get top story ids
    func getTopStories(completion: @escaping ([Int]) -> Void) {
        
        // Create url
        guard let url = URL(string: "\(Constants.baseURL)/topstories.json") else { return }
        
        // Create task
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            // Check if there is no error and data is exist
            guard let safeData = data, error == nil else { return }
            
            // Try to decode the data
            do {
                let results = try JSONDecoder().decode([Int].self, from: safeData)
                // Pass the results (array of Int)
                completion(results)
            } catch {
                print("Error getTopStories: \(error)")
            }
        }
        
        // Start task
        task.resume()
    }
    
    // Get ask story ids
    func getAskStories(completion: @escaping ([Int]) -> Void) {
        
        // Create url
        guard let url = URL(string: "\(Constants.baseURL)/askstories.json") else { return }
        
        // Create task
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            // Check if there is no error and data is exist
            guard let safeData = data, error == nil else { return }
            
            // Try to decode the data
            do {
                let results = try JSONDecoder().decode([Int].self, from: safeData)
                // Pass the results (array of Int)
                completion(results)
            } catch {
                print("Error getAskStories: \(error)")
            }
        }
        
        // Start task
        task.resume()
    }
    
    // Get show story ids
    func getShowStories(completion: @escaping ([Int]) -> Void) {
        
        // Create url
        guard let url = URL(string: "\(Constants.baseURL)/showstories.json") else { return }
        
        // Create task
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            // Check if there is no error and data is exist
            guard let safeData = data, error == nil else { return }
            
            // Try to decode the data
            do {
                let results = try JSONDecoder().decode([Int].self, from: safeData)
                // Pass the results (array of Int)
                completion(results)
            } catch {
                print("Error getShowStories: \(error)")
            }
        }
        
        // Start task
        task.resume()
    }
    
    // Get job story ids
    func getJobStories(completion: @escaping ([Int]) -> Void) {
        
        // Create url
        guard let url = URL(string: "\(Constants.baseURL)/jobstories.json") else { return }
        
        // Create task
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            // Check if there is no error and data is exist
            guard let safeData = data, error == nil else { return }
            
            // Try to decode the data
            do {
                let results = try JSONDecoder().decode([Int].self, from: safeData)
                // Pass the results (array of Int)
                completion(results)
            } catch {
                print("Error getJobStories: \(error)")
            }
        }
        
        // Start task
        task.resume()
    }
    
    // Get story by id
    func getStoryById(id: Int, completion: @escaping (Story) -> Void) {
        
        // Create url
        guard let url = URL(string: "\(Constants.baseURL)/item/\(id).json") else { return }
        
        // Create task
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            // Check if there is no error and data is exist
            guard let safeData = data, error == nil else { return }
            
            // Try to decode the data
            do {
                let results = try JSONDecoder().decode(Story.self, from: safeData)
                // Pass the results (Story)
                completion(results)
            } catch {
                print("Error getStoryById: \(error)")
            }
        }
        
        // Start task
        task.resume()
    }
}
