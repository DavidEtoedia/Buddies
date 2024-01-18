//
//  StackedView.swift
//  Buddies
//
//  Created by Inyene Etoedia on 08/01/2024.
//

import SwiftUI

struct StackedView: View {
    let stackedBuddies: [Buddies]
    let nameSpace : Namespace.ID
    let rotationAngles: [Double] = [10, 60, 45, 50]
    var body: some View {
        ZStack {
            ForEach(stackedBuddies.indices, id: \.self) { index in
                Rectangle()
                    .fill(.black)
                    .frame(width: 100, height: 100)
                    .matchedGeometryEffect(id: stackedBuddies[index].name, in: nameSpace, isSource: false)
                  //  .opacity(0)
                    .overlay{
                        VStack {
                            Circle()
                                .frame(height: 10)
                                .foregroundColor(stackedBuddies[index].isSelected ? .green : .white)
                                .frame(maxWidth: .infinity, alignment: .topTrailing)
                                .padding(.top, 5)
                                .padding(.trailing, 15)
                            Text(stackedBuddies[index].name)
                                .foregroundColor(.blue)
                                .padding(.top, 15)
                            
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                        
                    }
                    .offset(x: CGFloat(index % 2 == 0 ? index / 3 : -index / 4) * 50, y: 0)
                    .rotationEffect(Angle(degrees: (index % 2 == 0 ? rotationAngles[index] : -rotationAngles[index]) * 0.12))

            }
        }
        
    }
}

#Preview {
    StackedView(stackedBuddies: [.buddiess(), .buddiess()], nameSpace: Namespace().wrappedValue )
}
