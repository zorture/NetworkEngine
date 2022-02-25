//
//  MovieListDecodable.swift
//  NE iOS
//
//  Created by Kanwar Zorawar Singh Rana on 6/4/22.
//

import Foundation

struct MovieListDecodable: Decodable {
    let page: Decimal
    let total_results: Decimal?
    let total_pages: Decimal
    let results: [Movie]?
}

struct Movie: Decodable, Identifiable {
    var id = UUID()
    let title: String?
    let ovrView: String?
    let imagePath: String?
    let votes: Decimal?
    let imgId: Decimal
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case ovrView = "overview"
        case imagePath = "backdrop_path"
        case votes = "vote_average"
        case imgId = "id"
    }
}
