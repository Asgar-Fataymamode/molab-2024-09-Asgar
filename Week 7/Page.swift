//
//  Page.swift
//  FootballDiary
//
//  Created by Muhammad Ali Asgar Fataymamode on 23/10/2024.
//

import SwiftUI

// Data model for each page in the album
struct Page: Identifiable {
    var id = UUID()
    var image: UIImage?
    var description: String
}
