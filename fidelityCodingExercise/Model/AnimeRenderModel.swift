//
//  AnimeDisplayData.swift
//  fidelityCodingExercise
//
//  Created by Avinash Peddi on 11/19/20.
//  Copyright © 2020 Avinash Peddi. All rights reserved.
//

import Foundation
import SwiftUI

struct AnimeRenderModel: Identifiable {
    let id: String
    let title: String
    let ratings: [String]
    let summary: String
    let thumbnail: URL?
}


