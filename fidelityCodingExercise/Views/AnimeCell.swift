//
//  AnimeCell.swift
//  fidelityCodingExercise
//
//  Created by Avinash Peddi on 11/19/20.
//  Copyright © 2020 Avinash Peddi. All rights reserved.
//

import SwiftUI

struct AnimeCell: View {
    private let renderModel: AnimeRenderModel
    
    init(renderModel: AnimeRenderModel) {
        self.renderModel = renderModel
    }
    
    var body: some View {
        HStack {
			RemoteImage(url: self.renderModel.thumbnail?.absoluteString ?? "") ///TODO: Use placeholder imageUrl here
						.aspectRatio(contentMode: .fit)
						.frame(width: 65, height: 80)

            VStack(alignment: .leading) {
                Text(renderModel.title)
                    .font(.subheadline)
                    .fontWeight(.medium)

                HStack {
                    Text("Rated:")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    
                    ForEach(renderModel.ratings, id: \.self) { text in
                        Text(text)
							.font(.callout)
                    }
                }
            }
        }
        .frame(height: 88)
    }
}

#if DEBUG
let animeDemoData = AnimeRenderModel(id: UUID().uuidString, title: "Anime Finder Demo", ratings: ["PG-13"], summary: "Dummy Description", thumbnail: nil)

struct AnimeCell_Previews : PreviewProvider {
    static var previews: some View {
		AnimeCell(renderModel: animeDemoData)
            .previewLayout(.fixed(width: 300, height: 65))
            .previewDisplayName("AnimeCell")
    }
}
#endif

