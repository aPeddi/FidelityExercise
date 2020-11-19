//
//  AnimeDetail.swift
//  fidelityCodingExercise
//
//  Created by Avinash Peddi on 11/19/20.
//  Copyright © 2020 Avinash Peddi. All rights reserved.
//

import SwiftUI

struct AnimeDetail : View {
    @State private var animeImage: UIImage? = nil
    private let displayData: AnimeDisplayData
    
    init(displayData: AnimeDisplayData) {
        self.displayData = displayData
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Spacer()
					RemoteImage(url: self.displayData.thumbnail?.absoluteString ?? "")
								.aspectRatio(contentMode: .fit)
								.frame(width: 100, height: 150)
								.clipShape(Rectangle())
								.overlay(Rectangle().stroke(Color.gray, lineWidth: 1))
                    
                    Spacer()
                }
                
                Text(self.displayData.title)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding()
                
                if self.displayData.ratings.first != nil {
                    Text("Rated:")
                    .font(.footnote).fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .padding(0)
                    
                    ForEach(self.displayData.ratings, id: \.self) { author in
                        Text(author)
							.multilineTextAlignment(.leading)
                            .font(.footnote)
                            .lineLimit(1)
                            .padding(1)
                    }
                }                
                
                Text(self.displayData.summary)
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
        AnimeDetail(displayData: animeDemoData)
    }
}
#endif
