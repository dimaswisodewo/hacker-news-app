//
//  Story.swift
//  HackerNews
//
//  Created by Khushnidjon on 14/02/23.
//

import Foundation

struct Story: Decodable {
    let id: Int
    let score: Int
    let title: String
    let url: String?
}
