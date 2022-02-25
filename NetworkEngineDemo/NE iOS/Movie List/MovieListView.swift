//
//  MovieListView.swift
//  NetworkEngineExampleiOS
//
//  Created by Kanwar Zorawar Singh Rana on 6/3/22.
//

import SwiftUI

struct MovieListView: View {
    
    @StateObject var viewModel = MovieListViewModel()
    
    var body: some View {
        VStack {
            Text("Movie List")
            
            switch viewModel.requestStatus {
            case .loading:
                ProgressView()
                    .progressViewStyle(.circular)
            case .loaded(let results):
                List {
                    ForEach(results) { result in
                        Text(result.title ?? "No Title")
                    }
                }
            case .error(let error):
                Text(error.description)
            }
        }
        .onAppear {
            switch viewModel.requestStatus {
            case .loading:
                viewModel.fetchMovie()
            default:
                break
            }
        }
    }

}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
