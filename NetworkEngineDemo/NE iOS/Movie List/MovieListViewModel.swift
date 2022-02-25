//
//  MovieListViewModel.swift
//  NetworkEngineExampleiOS
//
//  Created by Kanwar Zorawar Singh Rana on 6/3/22.
//

import Foundation
import NetworkEngine

class MovieListViewModel: ObservableObject {
    
    @Published var requestStatus: RequestStatus<[Movie]> = .loading
    
    func fetchMovie() {
        Task {
            await requestMovieList(searchTerm: "Hulk")
        }
    }
    
    @MainActor
    func requestMovieList(searchTerm term: String) async {
        let query = MovieListQuery(pageNumber: "1", searchTerm: term)
        let request = MovieListRequest(searchQuery: query)
        do {
            let response = try await NetworkEngine
                .executeRequest(
                    urlRequest: request,
                    type: MovieListDecodable.self
                )
            
            switch response.results {
            case .some(let results):
                requestStatus = .loaded(result: results)
            case .none:
                requestStatus = .error(error: ServiceErrors.noData)
            }
        } catch {
            print(error)
        }
        
    }
}
