//
//  Story.swift
//  HackerNews
//
//  Created by Dimas Wisodewo on 28/01/23.
//

import Foundation

struct Story: Decodable {
    let id: Int
    let score: Int
    let title: String
    let url: String?
}
