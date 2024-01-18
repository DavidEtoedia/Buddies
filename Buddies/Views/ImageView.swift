//
//  ImageView.swift
//  Buddies
//
//  Created by Inyene Etoedia on 09/01/2024.
//

import SwiftUI

struct ImageView: View {
    var bgColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    let buddy: Buddies
    let  showCheckBox: Bool
    let toggleAction: (() -> Void)
    var body: some View {
        Image(buddy.image)
            .resizable()
            .scaledToFill()
            .frame(width: 77, height: 79)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding()
            .padding(.top, 8)
            .padding(.bottom, -5)
        
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(bgColor))
                    .overlay{
                        ZStack {
                           
                            StackedAmount(buddy: buddy)
                                .opacity(!buddy.items.isEmpty ? 1 : 0)
                                .zIndex(1)
                                .offset(x: -28, y: -45)
                           
                            VStack{
                                HStack(spacing: 0){
                                  
                                    Spacer()
                                    CheckBox(isSelected: buddy.isSelected)
                                        .opacity(showCheckBox ? 1 : 0)
                                        .padding(.trailing, 10)
                                        .padding(.top, 5)
                                        .onTapGesture(perform: toggleAction)
                                }
                               
                            }
                            .frame(maxHeight: .infinity, alignment: .topTrailing)
                        }
                
                    }
            )
    }
}

#Preview {
    ImageView(buddy: .buddiess(), showCheckBox: true, toggleAction: {})
}
