//
//  ContentView.swift
//  Buddies
//
//  Created by Inyene Etoedia on 02/01/2024.
//

import SwiftUI

struct ContentView: View {
    var bgColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
  // @State var vm = Controller()
    @Environment(Controller.self) private var vm
    let columnCount = 3
    let columnSpacing: CGFloat = -25
    let rowSpacing: CGFloat = 10
    let rotationAngles: [Double] = [45, 50]
    
    let itemColumnSpacing: CGFloat = -100
    let itemColumnCount = 3
    let itemRowSpacing: CGFloat = 10
    @State var isStack = false
    @State var showCheckBox: Bool = false
    @State var showStackTray: Bool = false
    @State var showSheet: Bool = false
    @State private var buddy: Buddies? = nil
    @Namespace var nameSpace
    private var namespace: Namespace.ID {
          Namespace().wrappedValue
      }
    
    var columns: [GridItem]{
        Array(repeating: .init(spacing: columnSpacing), count: columnCount)
    }
    var itemColumns: [GridItem]{
        Array(repeating: .init(spacing: itemColumnSpacing), count: itemColumnCount)
    }
    var body: some View {
     
            VStack {
                HStack {
                    Text("Splitz")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(.blue)
                    Spacer()
                    Button(action: {
                        withAnimation(.bouncy) {
                            if(vm.stackedBuddies.isEmpty){
                                showCheckBox.toggle()
                                vm.deselectVal()
                            }
                        }
                      
                       
                    }, label: {
                        HStack {
                            Text("Split")
                            Image(systemName: "square.split.diagonal")
                        }
                    })
                    .buttonStyle(.borderedProminent)
                    .padding(.bottom, 30)
                    .padding(.top, 30)
                }
                .padding(.horizontal, 20)
                
                
                ZStack {
                    LazyVGrid(columns: columns, spacing: rowSpacing) {
                        ForEach(vm.buddies.indices, id: \.self) { index in
                            ZStack {
                                HoverView(isTarget: vm.buddies[index].isTargeted)
                                   
                                
                                VStack{
                                    ImageView(buddy: vm.buddies[index], showCheckBox: showCheckBox,  toggleAction: {
                                        vm.selectedValue(name: vm.buddies[index])
                                    })
                                        .matchedGeometryEffect(id: vm.buddies[index].id, in: nameSpace)
                                        
                                    .scaleEffect(
                                         vm.buddies[index].isSelected ? 0.95 :
                                        showCheckBox ? 0.90 :
                                           (vm.buddies[index].isTargeted ? 1.05 : 0.95)
                                    
                                    )
                                    .animation(.bouncy(extraBounce: 0.1), value:   vm.buddies[index].isSelected)
                                    .dropDestination(for: AmountTagItem.self) { items, location in
                                        withAnimation {
                                            for task in items {
                                                withAnimation(.bouncy) {
                                                    vm.onDropValue(name: vm.buddies[index], item: task)
                                                }
                                            }
                                            
                                        }
                                        return false
                                    } isTargeted: { status in
                                        withAnimation(.bouncy( extraBounce: 0.3)) {
                                            vm.isTargeted(name: vm.buddies[index])

                                        }
                                    }
                                    .onTapGesture(perform: {
                                        showSheet.toggle()
                                       buddy = vm.buddies[index]
                                    })
                                    .sheet(item: $buddy) { val in
                                        DetailsView(buddie: val, action: {
                                
                                        })
                                            .presentationDetents([.medium])
                                    }
                                   
                                    Spacer()
                                        .frame(height: 10)
                                    Text(vm.buddies[index].name)
                                        .font(.system(size: 15))
                                        .foregroundColor(.blue)
                                        .opacity(isStack ? 0 : 1)
                                    
                                }
                            }

                        }
                        
                    }
                   

                    if(!vm.stackedBuddies.isEmpty){
                        SelectedStack(isStack: $isStack, showCheckBox: $showCheckBox, nameSpace: nameSpace)
                        
//                        ZStack {
//                            Rectangle()
//                                .fill(.ultraThinMaterial)
//                                .frame(width: 200, height: 200)
//                                .cornerRadius(30)
//                                .animation(.bouncy(extraBounce: 0.4), value: isStack)
//                            ForEach(Array(vm.stackedBuddies.enumerated().reversed()), id: \.element.name) { (index, element) in
//                                
//                                ZStack {
//                                    ImageView(buddy: element, showCheckBox: showCheckBox, toggleAction: {
//                                        vm.selectedValue(name: vm.buddies[index])
//                                    })
//                                    .matchedGeometryEffect(id: element.id, in: nameSpace)
//                                    .offset(x: CGFloat(index % 2 == 0 ? index / 3 : -index / 4) * 50, y: 0)
//                                    .rotationEffect(Angle(degrees: (index % 2 == 0 ? rotationAngles[min(index, rotationAngles.count - 1)] : -rotationAngles[min(index, rotationAngles.count - 1)]) * 0.12))
//                                }
//                                .zIndex(1)
//                                .dropDestination(for: AmountTagItem.self) { items, location in
//                                    
//                                    withAnimation(.bouncy) {
//                                        for task in items {
//                                            vm.onDropStackValue( item: task)
//                                        }
//                                    }
//                                    return false
//                                } isTargeted: { status in }
//                          
//                            }
//
//                        }
                    }

                }

                Spacer()
                    .frame(height: 60)
                
                
                
                ProductTagView(tags: vm.priceTag, action: {
                    withAnimation(.bouncy(extraBounce: 0.06)) {
                    
                            if(showCheckBox){
                                showCheckBox = false
                                isStack = true
                                showStackTray = true
                                vm.stack()
                            }
                        }

                })

            }
            .frame(maxHeight: .infinity, alignment: .top)
            .background{
                Color.white
                    .onTapGesture {
                        if(isStack){
                            withAnimation(.bouncy) {
                                isStack = false
                                print(isStack)
                                vm.unStack()
                            }
                            
                        }
                    }
                
            }

    }
}


#Preview {
    ContentView()
        .environment(Controller())
}










