//
//  BudDetails.swift
//  Buddies
//
//  Created by Inyene Etoedia on 09/01/2024.
//

import SwiftUI

struct BudDetails: View {
    @Binding var buddy: Buddies
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    BudDetails(buddy: .constant(.buddiess()))
}
