//
//  StackedAmount.swift
//  Buddies
//
//  Created by Inyene Etoedia on 09/01/2024.
//

import SwiftUI

struct StackedAmount: View {
    let buddy: Buddies
    //let nameSpace: Namespace.ID
    var body: some View {
        HStack {
            HStack(spacing: 0){
                TagCountView(name: buddy.items.count)
                    .opacity(buddy.items.isEmpty ? 1 : 1)
                    .padding(.leading, 2)
                    .fixedSize(horizontal: true, vertical: false)
                
                Text(buddy.amount, format: .currency(code: "NGN"))
                    .font(.system(size: 13, weight: .regular))
                    .contentTransition(.numericText())
                    .foregroundColor(.white)
        
            }
            .padding(.trailing, 5)
            .background(content: {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.gray)
                    .strokeBorder(Color.blue,lineWidth: 1.5)
                   // .matchedGeometryEffect(id: buddy.rectId, in: nameSpace)
                
        })
        }
        

    }
}

#Preview {
    StackedAmount(buddy: .buddiess())
}
