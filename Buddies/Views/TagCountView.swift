//
//  TagCountView.swift
//  Buddies
//
//  Created by Inyene Etoedia on 07/01/2024.
//

import SwiftUI

struct TagCountView: View {
    let name: Int
    var body: some View {
        Text("\(name)")
            .font(.system(size: 10, weight: .bold))
            .foregroundColor(.white)
            .padding(.all, 6)
            .background{
                Circle()
                    .fill(.gray)
                    .strokeBorder(Color.blue,lineWidth: 2)
//                    .frame(height: 20)
                  
            }
    }
}

#Preview {
    TagCountView(name: 0)
}
