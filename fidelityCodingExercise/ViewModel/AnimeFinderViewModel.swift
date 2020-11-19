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
    @Published var searchText = ""
    @Published private (set) var items = [AnimeDisplayData]()
    @Published private (set) var itemImages = [String: UIImage]()
    
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
        
        searchCancellable = $searchText
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .filter { !$0.isEmpty && $0.first != " " }
            .flatMap { (searchString) -> AnyPublisher<[AnimeResult], Never> in
                print("searchString: \(searchString)")
				var url: URL = APIService.dummyUrl
				if let urlString = URL.init(string: APIService.baseURL + searchString){
					url = urlString
				}
                return APIService.searchBy(url: url)
                    .replaceError(with: []) //TODO: Handle Errors
                    .eraseToAnyPublisher()
            }
            .map {
                self.animesToBookDisplayData(animes: $0)
            }
            .replaceError(with: []) //TODO: Handle Errors
            .assign(to: \.items, on: self)
    }

    private func animesToBookDisplayData(animes: [AnimeResult]) -> [AnimeDisplayData]  {
        var displayDataItems = [AnimeDisplayData]()
        
        animes.forEach {
			let displayData = AnimeDisplayData(id: String($0.mal_id), title: $0.title, ratings: [$0.rated ?? ""], summary: $0.synopsis, thumbnail: URL.init(string: $0.image_url))
            displayDataItems.append(displayData)
        }
        return displayDataItems
    }
}

