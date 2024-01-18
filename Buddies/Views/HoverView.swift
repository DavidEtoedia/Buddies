//
//  HoverView.swift
//  Buddies
//
//  Created by Inyene Etoedia on 07/01/2024.
//

import SwiftUI

struct HoverView: View {
    var deviceBg = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    let isTarget: Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(   isTarget ? .clear : .clear)
            .padding(.horizontal, 4)
            .frame(width: 130, height: 150)
            .shadow(color: .gray.opacity(0.3), radius: 7)

    }
}

#Preview {
    HoverView(isTarget: true)
}
