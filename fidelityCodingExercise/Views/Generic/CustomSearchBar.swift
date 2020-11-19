//
//  CustomSearchBar.swift
//  fidelityCodingExercise
//
//  Created by Avinash Peddi on 11/19/20.
//  Copyright © 2020 Avinash Peddi. All rights reserved.
//

import SwiftUI

struct CustomSearchBar : View {
    @Binding var text: String
    
    var body: some View {
        ZStack {
			Color.black.opacity(0.4)
            HStack {                
                TextField("Search", text: $text)
                    .padding([.leading, .trailing], 8)
                    .frame(height: 32)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(8)
                }
                  .padding([.leading, .trailing], 16)
            }
            .frame(height: 64)
    }

}

#if DEBUG
struct CustomSearchBar_Previews : PreviewProvider {
    static var previews: some View {
        CustomSearchBar(text: .constant(""))
            .previewLayout(.fixed(width: 300, height: 60))
    }
}
#endif
