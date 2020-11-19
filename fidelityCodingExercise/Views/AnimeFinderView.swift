//
//  AnimeFinderView.swift
//  fidelityCodingExercise
//
//  Created by Avinash Peddi on 11/19/20.
//  Copyright © 2020 Avinash Peddi. All rights reserved.
//

import SwiftUI

struct AnimeFinderView : View {
    @ObservedObject private var viewModel = AnimeFinderViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                CustomSearchBar(text: $viewModel.searchText)
                List(viewModel.items) { item in
                    NavigationLink(destination: AnimeDetail(displayData: item)) {
                        AnimeCell(displayData: item)
                    }
                }
            }
            .navigationBarTitle(Text("Anime Finder"))
        }
    }
}

#if DEBUG
struct AnimeFinderView_Previews : PreviewProvider {
    static var previews: some View {
        AnimeFinderView()
    }
}
#endif