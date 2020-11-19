//
//  AnimeCell.swift
//  fidelityCodingExercise
//
//  Created by Avinash Peddi on 11/19/20.
//  Copyright © 2020 Avinash Peddi. All rights reserved.
//

import SwiftUI

struct AnimeCell: View {
    @State private var animeImage: UIImage? = nil
    private let displayData: AnimeDisplayData
    
    init(displayData: AnimeDisplayData) {
        self.displayData = displayData
    }
    
    var body: some View {
        HStack {
			RemoteImage(url: self.displayData.thumbnail?.absoluteString ?? "")
						.aspectRatio(contentMode: .fit)
						.frame(width: 50, height: 65)

            VStack(alignment: .leading) {
                Text(displayData.title)
                    .font(.subheadline)
                    .fontWeight(.medium)

                HStack {
                    Text("Rated:")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                    
                    ForEach(displayData.ratings, id: \.self) { e in
                        Text(e)
                            .font(.footnote)
                    }
                }
            }
        }
        .frame(height: 65)
    }
}

#if DEBUG
let animeDemoData = AnimeDisplayData(id: "1234", title: "Anime Finder Demo", ratings: ["PG-13"], summary: "Dummy Description", thumbnail: nil)

struct AnimeCell_Previews : PreviewProvider {
    static var previews: some View {
        AnimeCell(displayData: animeDemoData)
            .previewLayout(.fixed(width: 300, height: 65))
            .previewDisplayName("AnimeCell")
    }
}
#endif

