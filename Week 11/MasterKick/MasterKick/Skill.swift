//
//  Skill.swift
//  MasterKick
//
//  Created by Muhammad Ali Asgar Fataymamode on 21/11/2024.
//

import Foundation

struct Skill: Identifiable {
    let id = UUID() // Unique identifier
    let title: String
    let youtubeURL: String
    let explanation: String
}
