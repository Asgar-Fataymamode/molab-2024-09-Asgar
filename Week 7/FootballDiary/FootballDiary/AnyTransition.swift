//
//  AnyTransition.swift
//  FootballDiary
//
//  Created by Muhammad Ali Asgar Fataymamode on 23/10/2024.
//


import SwiftUI

extension AnyTransition {
    static var pageCurl: AnyTransition {
        .asymmetric(
            insertion: .modifier(
                active: PageCurlViewModifier(angle: -180),
                identity: PageCurlViewModifier(angle: 0)
            ),
            removal: .modifier(
                active: PageCurlViewModifier(angle: 180),
                identity: PageCurlViewModifier(angle: 0)
            )
        )
    }
}

struct PageCurlViewModifier: ViewModifier {
    var angle: Double

    func body(content: Content) -> some View {
        content
            .rotation3DEffect(
                .degrees(angle),
                axis: (x: 0, y: 1, z: 0),
                perspective: 0.5
            )
    }
}
