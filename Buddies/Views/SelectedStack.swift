//
//  SelectedStack.swift
//  Buddies
//
//  Created by Inyene Etoedia on 18/01/2024.
//

import SwiftUI

struct SelectedStack: View {
    @Binding var isStack: Bool
    @Binding var showCheckBox: Bool
    let rotationAngles: [Double] = [45, 50]
    let nameSpace: Namespace.ID
    @Environment(Controller.self) private var vm
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .frame(width: 200, height: 200)
                .cornerRadius(30)
                .animation(.bouncy(extraBounce: 0.4), value: isStack)
            ForEach(Array(vm.stackedBuddies.enumerated().reversed()), id: \.element.name) { (index, element) in
                ZStack {
                    ImageView(buddy: element, showCheckBox: showCheckBox, toggleAction: {
                        vm.selectedValue(name: vm.buddies[index])
                    })
                    .shadow(color:.gray.opacity(0.2),  radius: 4.7)
                    .matchedGeometryEffect(id: element.id, in: nameSpace)
                    .offset(x: CGFloat(index % 2 == 0 ? index / 3 : -index / 4) * 50, y: 0)
                    .rotationEffect(Angle(degrees: (index % 2 == 0 ? rotationAngles[min(index, rotationAngles.count - 1)] : -rotationAngles[min(index, rotationAngles.count - 1)]) * 0.12))
                }
                .zIndex(1)
                .dropDestination(for: AmountTagItem.self) { items, location in
                    withAnimation(.bouncy) {
                        for task in items {
                            vm.onDropStackValue( item: task)
                        }
                    }
                    return false
                } isTargeted: { status in }
          
            }

        }
    }
}

#Preview {
    SelectedStack(isStack: .constant(true), showCheckBox: .constant(true), nameSpace: Namespace().wrappedValue)
        .environment(Controller())
}
