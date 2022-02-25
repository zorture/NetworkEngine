//
//  ContentView.swift
//  NE iOS
//
//  Created by Kanwar Zorawar Singh Rana on 6/3/22.
//

import SwiftUI

enum Examples: Int, CaseIterable {
    case movieList
    
    var title: String {
        switch self {
        case .movieList:
            return "Movie List"
        }
    }
    
    var router: some View {
        switch self {
        case .movieList:
            return MovieListView()
        }
    }
}

struct ContentView: View {

    var body: some View {
        NavigationView {
            List(Examples.allCases, id: \.self) { example in
                NavigationLink(example.title, destination: example.router)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
