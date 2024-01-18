//
//  productView.swift
//  Buddies
//
//  Created by Inyene Etoedia on 18/01/2024.
//

import SwiftUI


struct ProductTagView: View {
    var tags: [AmountTagItem]
   @State  var totalHeight = CGFloat.zero
    let action: (() -> Void)?
    var deviceBg = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    var body: some View {
        VStack (spacing: 0) {
            HStack(spacing: 0) {
              
                Text("Purchased Drinks ")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.blue)
            
                Text("🍻")
                    .font(.system(size: 35, weight: .bold))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 5)
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .padding(.horizontal, 20)
        .frame(height: totalHeight)
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return ZStack(alignment: .topLeading) {
            
            ForEach(tags.indices, id: \.self) { index in
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text(tags[index].name)
                        .font(.system(size: 12,  weight: .bold))
                        .foregroundColor( .blue)
                        Text("x\(String(tags[index].quantity))")
                            .font(.system(size: 13, weight: .medium))
                        .foregroundColor( .gray )
                    }
                        Text(tags[index].total, format: .currency(code: "NGN"))
                            .font(.system(size: 12, weight: .light))
                        .foregroundColor( .black )

                   }
                .padding(.all, 9)
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(deviceBg))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 0.5)
                                .foregroundColor(.blue)
                                .shadow(radius: 0.5)
                        )
                   }
                .contentShape(.dragPreview, .rect(cornerRadius: 10))
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tags[index].name == self.tags.last!.name {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tags[index].name == self.tags.last!.name {
                            height = 0
                        }
                        return result
                    })
                    .draggable(tags[index]) {
                        
                        VStack(alignment: .leading, spacing: 0){
                            HStack {
                                Text(tags[index].name)
                                    .font(.system(size: 12,  weight: .bold))
                                    .foregroundColor( .blue)
                                Text("x1")
                                    .font(.system(size: 13, weight: .medium))
                                .foregroundColor( .gray )
                            }
                            Text(tags[index].amount, format: .currency(code: "NGN"))
                                .font(.system(size: 12, weight: .light))
                                .foregroundColor( .black )
                           }
                        .padding(.all, 10)
                        .background{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(deviceBg))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 0.5)
                                        .foregroundColor(.blue)
                                        .shadow(radius: 0.5)
                                )
                        }
                        .contentShape(.dragPreview, .rect(cornerRadius: 10))
                        .padding(.vertical, 3)
                        .onDisappear(perform:action)
                        
 
                    }
            }
        }
    }


    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

#Preview {
    ProductTagView(tags: [AmountTagItem(amount: 0.0, name: "Goldberg", quantity: 2)], action: {})
}
