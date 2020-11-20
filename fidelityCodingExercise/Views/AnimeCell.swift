//
//  AnimeCell.swift
//  fidelityCodingExercise
//
//  Created by Avinash Peddi on 11/19/20.
//  Copyright © 2020 Avinash Peddi. All rights reserved.
//

import SwiftUI

struct AnimeCell: View {
    private let processedData: AnimeProcessedData
    
    init(processedData: AnimeProcessedData) {
        self.processedData = processedData
    }
    
    var body: some View {
        HStack {
			RemoteImage(url: self.processedData.thumbnail?.absoluteString ?? "") ///TODO: Use placeholder imageUrl here
						.aspectRatio(contentMode: .fit)
						.frame(width: 65, height: 80)

            VStack(alignment: .leading) {
                Text(processedData.title)
                    .font(.subheadline)
                    .fontWeight(.medium)

                HStack {
                    Text("Rated:")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                    
                    ForEach(processedData.ratings, id: \.self) { e in
                        Text(e)
                            .font(.footnote)
                    }
                }
            }
        }
        .frame(height: 88)
    }
}

#if DEBUG
let animeDemoData = AnimeProcessedData(id: UUID().uuidString, title: "Anime Finder Demo", ratings: ["PG-13"], summary: "Dummy Description", thumbnail: nil)

struct AnimeCell_Previews : PreviewProvider {
    static var previews: some View {
        AnimeCell(processedData: animeDemoData)
            .previewLayout(.fixed(width: 300, height: 65))
            .previewDisplayName("AnimeCell")
    }
}
#endif

