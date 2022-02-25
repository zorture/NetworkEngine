//
//  MovieListRequest.swift
//  NetworkEngineExampleiOS
//
//  Created by Kanwar Zorawar Singh Rana on 6/3/22.
//

import Foundation
import NetworkEngine

struct MovieListRequest: NetworkEngineRequest {
    
    let searchQuery: MovieListQuery!
    
    var query: NetworkEngineEncoder? {
        searchQuery
    }
    
    var jsonData: NetworkEngineEncoder?
    
    var body: Data?
    
    var headers: StringDictionary?
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org")!
    }
    
    var path: String? {
        return "/3/search/movie"
    }
}

struct MovieListQuery: NetworkEngineEncoder {
    let pageNumber: String
    let searchTerm: String
    let key = "2a61185ef6a27f400fd92820ad9e8537"
    
    enum CodingKeys: String, CodingKey {
        case pageNumber = "page"
        case searchTerm = "query"
        case key = "api_key"
    }
}
