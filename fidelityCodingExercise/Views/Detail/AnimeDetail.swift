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
    private let processedData: AnimeProcessedData
    
    init(processedData: AnimeProcessedData) {
        self.processedData = processedData
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Spacer()
					RemoteImage(url: self.processedData.thumbnail?.absoluteString ?? "")
								.aspectRatio(contentMode: .fit)
						.frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.width)
								.clipShape(Rectangle())
								.overlay(Rectangle().stroke(Color.gray, lineWidth: 1))
                    
                    Spacer()
                }
                
                Text(self.processedData.title)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding()
                
                if self.processedData.ratings.first != nil {
                    Text("Rated:")
                    .font(.footnote).fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .padding(0)
                    
                    ForEach(self.processedData.ratings, id: \.self) { rating in
                        Text(rating)
							.multilineTextAlignment(.leading)
                            .font(.footnote)
                            .lineLimit(1)
                            .padding(1)
                    }
                }                
                
                Text(self.processedData.summary)
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
        AnimeDetail(processedData: animeDemoData)
    }
}
#endif
