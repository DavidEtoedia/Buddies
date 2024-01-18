//
//  CheckBox.swift
//  Buddies
//
//  Created by Inyene Etoedia on 09/01/2024.
//

import SwiftUI

struct CheckBox: View {
    let isSelected: Bool
    var body: some View {
        Circle()
            .frame(height: 11)
            .foregroundColor(isSelected ? .green : .white)
            .overlay{
                RoundedRectangle(cornerRadius: 30)
                    .stroke(lineWidth: 1.5)
                    .fill(.blue)
                    .frame(width: 17, height: 17)
            }
    }
}

#Preview {
    CheckBox(isSelected: true)
}
