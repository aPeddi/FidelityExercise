//
//  AnimeDetail.swift
//  fidelityCodingExercise
//
//  Created by Avinash Peddi on 11/19/20.
//  Copyright © 2020 Avinash Peddi. All rights reserved.
//

import SwiftUI

///Detail Page Implementation for Anime
struct AnimeDetail : View {
    private let renderModel: AnimeRenderModel
    
    init(renderModel: AnimeRenderModel) {
        self.renderModel = renderModel
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Spacer()
					RemoteImage(url: self.renderModel.thumbnail?.absoluteString ?? "")
								.aspectRatio(contentMode: .fit)
						.frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.width)
								.clipShape(Rectangle())
                    
                    Spacer()
                }
                
                Text(self.renderModel.title)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding()
                
                if self.renderModel.ratings.first != nil {
                    Text("Rated:")
                    .font(.callout).fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .padding(0)
                    
                    ForEach(self.renderModel.ratings, id: \.self) { rating in
                        Text(rating)
							.multilineTextAlignment(.leading)
                            .font(.callout)
                            .lineLimit(1)
                            .padding(1)
                    }
                }                
                
                Text(self.renderModel.summary)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
					.padding()
            }
        }
    }
}

#if DEBUG
struct AnimeDetail_Previews : PreviewProvider {
    static var previews: some View {
		AnimeDetail(renderModel: animeDemoData)
    }
}
#endif
