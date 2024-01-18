//
//  DetailsView.swift
//  Buddies
//
//  Created by Inyene Etoedia on 11/01/2024.
//

import SwiftUI

struct DetailsView: View {
    @Environment(Controller.self) private var vm
    @Environment(\.dismiss) var dismiss
    @State  var buddie: Buddies
    let action: ()-> Void
    var body: some View {
        VStack{
            HStack {
                Image(buddie.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                Spacer()
                    .frame(width: 20)
                Text(buddie.name)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()

           
            ForEach(Array((buddie.items.enumerated())), id: \.element.name) { (index, element) in
                    HStack {
                        HStack {
                            Text(element.name)
                                .font(.system(size: 18, weight: .regular))
                            Spacer()
                                .frame(width: 10)
                            Text("x\(element.quantity.description)")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.gray)
                                .contentTransition(.numericText())
                            Spacer()
                            Text(element.total, format: .currency(code: "NGN"))
                                .font(.system(size: 16, weight: .regular))
                                .contentTransition(.numericText())
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.06)))
                        .padding(.bottom, 10)
                        
                        Button {
                            vm.removeItem(buddy: buddie, itemIndex: index)
                            if(element.quantity == 1 ){
                                buddie.removeItem(at: index)
                               
                            }else {
                                buddie.reduceQuantity(at: index)
                            }
                            
                            if(buddie.items.isEmpty){
                                dismiss()
                            }
                        
                        } label: {
                            Text("Remove")
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(.red)
                        }
                        
                    }
                    .padding(.horizontal, 20)
                
                
                }
           // Spacer()
              
              
            VStack {
                Text("Total")
                    .font(.system(size: 15))
                 .frame(maxWidth: .infinity, alignment: .trailing)
                 .padding(.bottom, 1)
                Text(buddie.amount, format: .currency(code: "NGN"))
                    .font(.system(size: 23, weight: .bold))
                    .contentTransition(.numericText())
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
                
        }
    }
    
  
}

#Preview {
    DetailsView(buddie: .buddiess(), action: {})
        .environment(Controller())
        
}

