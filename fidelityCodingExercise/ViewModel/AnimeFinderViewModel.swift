//
//  AnimeFinderViewModel.swift
//  fidelityCodingExercise
//
//  Created by Avinash Peddi on 11/19/20.
//  Copyright © 2020 Avinash Peddi. All rights reserved.
//

import SwiftUI
import Combine

final class AnimeFinderViewModel: ObservableObject {
	@Published private (set) var items = [AnimeRenderModel]()
    @Published var searchString = ""
    
    private var searchCancellable: Cancellable? {
        didSet {
            oldValue?.cancel()
        }
    }
    
    deinit {
        searchCancellable?.cancel()
    }
    
    init () {
        print("Init ViewModel")
        
        searchCancellable = $searchString
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .removeDuplicates()
			/// Ground Rules for Search Text
			/// - no empty values
			/// - cannot start with whitespace
			.filter { !$0.isEmpty && $0.first != " " }
            .flatMap { (searchString) -> AnyPublisher<[AnimeResult], Never> in
                print("searchString: \(searchString)")
                return AnimeSearchService.searchBy(string: searchString)
                    .replaceError(with: []) ///TODO: Error Handling
                    .eraseToAnyPublisher()
            }
            .map {
                self.createRenderModelItems(animes: $0)
            }
            .replaceError(with: []) ///TODO: Error Handling
            .assign(to: \.items, on: self)
    }

	/// converts data model to a generic render model to be passed on to the view
	/// - Parameter animes: anime items obtained from service response
	/// - Returns: generic view display render models
    private func createRenderModelItems(animes: [AnimeResult]) -> [AnimeRenderModel]  {
        var renderModelItems = [AnimeRenderModel]()
        
        animes.forEach {
			let renderModel = AnimeRenderModel(id: String($0.mal_id), title: $0.title, ratings: [$0.rated ?? ""], summary: $0.synopsis, thumbnail: URL.init(string: $0.image_url))
			renderModelItems.append(renderModel)
        }
        return renderModelItems
    }
}

