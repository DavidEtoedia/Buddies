//
//  Controller.swift
//  Buddies
//
//  Created by Inyene Etoedia on 02/01/2024.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers
import OSLog

@Observable class Controller {
    var buddies: [Buddies] = []
    var priceTag: [AmountTagItem] = []
    
    var stackedBuddies: [Buddies] = []
    let logger = Logger()
    
    
    init(){
        innit()
        innitAmount()
    }
    
    
   func innit(){
       let res = [
        Buddies(name: "Slim", image: "chris 1", amount: 0.0, isSelected: false, isTargeted: false, items: []),
        Buddies(name: "Omoba 101", image: "cy 1", amount: 0.0,   isSelected: false, isTargeted: false, items: []),
        Buddies(name: "Ogbeni", image: "ogbeni", amount: 0.0, isSelected: false, isTargeted: false, items: []),
        Buddies(name: "Eleshin", image: "eleshin", amount: 0.0, isSelected: false, isTargeted: false, items: []),
        Buddies(name: "Oak", image: "deji", amount: 0.0, isSelected: false, isTargeted: false, items: []),
        Buddies(name: "Laolu", image: "laolu", amount: 0.0, isSelected: false, isTargeted: false, items: []),
       ]
       buddies.append(contentsOf: res)
    }
    
    func innitAmount(){
        let res = [
            AmountTagItem(amount: 500.0, name: "GoldBerg", quantity: 5),
            AmountTagItem(amount: 340.0, name: "Martel", quantity: 2),
            AmountTagItem(amount: 500.0, name: "Jameson", quantity: 3),
            AmountTagItem(amount: 700.0, name: "Glenfiddich", quantity: 3),
            AmountTagItem(amount: 100.0, name: "Water", quantity: 2),
            AmountTagItem(amount: 120.0, name: "Action bitters", quantity: 8),
            AmountTagItem(amount: 100.0, name: "Jedi", quantity: 2),
//            AmountTag(amount: 100.0, name: "Jedi"),
//            AmountTag(amount: 100.0, name: "Asun"),
        ]
        priceTag.append(contentsOf: res)
     }
    
    func isTargeted(name: Buddies){
        if let index = buddies.firstIndex(where: {$0.name == name.name}){
            buddies[index].isTargeted.toggle()
        }
    }
    
    func selectedValue(name: Buddies){
        if let index = buddies.firstIndex(where: {$0.name == name.name}){
            buddies[index].isSelected.toggle()
        }
       
    }
    func removeItem(buddy: Buddies, itemIndex: Int){
        if let index = buddies.firstIndex(where: { $0.id == buddy.id }) {
                  let itemAmount = buddies[index].items[itemIndex].amount
                  let itemQuantity = buddies[index].items[itemIndex].quantity
            if let priceTagIndex  = priceTag.firstIndex(where: {$0.name == buddies[index].items[itemIndex].name }){
                priceTag[priceTagIndex].quantity += 1
              }
                  if itemQuantity == 1 {
                      // Remove the item and set buddies.amount to 0.0 for only the selected item
                      buddies[index].items.remove(at: itemIndex)
                      buddies[index].amount = buddies[index].items.reduce(0.0) { $0 + $1.amount }
                  } else {
                      // Decrement the quantity and update the amount
                      buddies[index].items[itemIndex].quantity -= 1
                      buddies[index].amount -= itemAmount
                    
                      
                  }
              }
    }
    
    func deselectVal(){
        for selectedVal in buddies.indices{
            buddies[selectedVal].isSelected = false
        }
    }
    
    func stack(){
        let selected = buddies.filter({ $0.isSelected == true })
    
        stackedBuddies.append(contentsOf: selected)
        
    }
    
    func unStack(){
        for index in buddies.indices {
               buddies[index].isSelected = false
           }
            
        stackedBuddies.removeAll()
    }
    
    
    func onDropValue(name: Buddies, item: AmountTagItem){
        
        if let itemIndex = priceTag.firstIndex(where: {$0.name == item.name}){
            if (priceTag[itemIndex].quantity == 0){return}
             priceTag[itemIndex].quantity -= 1
            
            if let index = buddies.firstIndex(where: {$0.name ==  name.name}){
                
                let sumNumbers = item.amount + buddies[index].amount
                buddies[index].amount = sumNumbers

                if let indexs = buddies[index].items.firstIndex(where: {$0.name == item.name}){
                
                    buddies[index].items[indexs].quantity += 1
                } else {
                    let itees = item.copy(quantity: +1)
                    buddies[index].items.append(itees)
                }
            
            }
         
         }
        
       
     
       
    }
    
    func onDropStackValue(item: AmountTagItem){
        
        if let itemIndex = priceTag.firstIndex(where: { $0.name == item.name }) {
            let availableQuantity = min(priceTag[itemIndex].quantity, stackedBuddies.count)

               if availableQuantity > 0 {
                   // Decrement priceTag.quantity based on availableQuantity
                   priceTag[itemIndex].quantity -= availableQuantity
                   

                   // Iterate through available quantity in stackedBuddies
                   for (index, stackedBuddy) in stackedBuddies.prefix(availableQuantity).enumerated() {
                       let sumNumbers = item.amount + stackedBuddy.amount

                       // Update stackedBuddies.amount
                       stackedBuddies[index].amount = sumNumbers

                       // Update stackedBuddies.quantity and stackedBuddies.items
                       if let stackItemIndex = stackedBuddy.items.firstIndex(where: { $0.name == item.name }) {
                           stackedBuddies[index].items[stackItemIndex].quantity += 1
                       } else {
                           let stackItems = item.copy(quantity: +1)
                           stackedBuddies[index].items.append(stackItems)
                       }

                       // Update buddies.amount and buddies.items
                       if let buddieIndex = buddies.firstIndex(where: { $0.name == stackedBuddy.name }) {
                           buddies[buddieIndex].amount = sumNumbers

                           if let itemIndex = buddies[buddieIndex].items.firstIndex(where: { $0.name == item.name }) {
                               buddies[buddieIndex].items[itemIndex].quantity += 1
                           } else {
                               let itees = item.copy(quantity: +1)
                               buddies[buddieIndex].items.append(itees)
                           }
                       }
                   }
            } else {
                if let itemIndex = priceTag.firstIndex(where: {$0.name == item.name}){
                    if (priceTag[itemIndex].quantity == 0){return}
                    priceTag[itemIndex].quantity -= stackedBuddies.count

                    for index in stackedBuddies.indices {
                        let sumNumbers = item.amount + stackedBuddies[index].amount
                        stackedBuddies[index].amount = sumNumbers
                        
                        
                        if let stackItemIndex =  stackedBuddies[index].items.firstIndex(where: {$0.name == item.name}){
                            stackedBuddies[index].items[stackItemIndex].quantity += 1
                        }else{
                            let stackItems = item.copy(quantity: +1)
                            stackedBuddies[index].items.append(stackItems)
                        }
                        
                        if let buddieIndex = buddies.firstIndex(where: {$0.name ==  stackedBuddies[index].name}){
                            buddies[buddieIndex].amount = sumNumbers
                            if let itemIndex = buddies[buddieIndex].items.firstIndex(where: { $0.name == item.name }) {
                                // Increment the quantity if the item's name exists
                                buddies[buddieIndex].items[itemIndex].quantity += 1
                                
                            } else {
                                let itees = item.copy(quantity: +1)
                                buddies[buddieIndex].items.append(itees)
                            }
                            
                        }
                    }
                    }
                    
                }
            }
        
       
    }
    
}



struct Buddies: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let image: String
    var amount: Double
    var isSelected: Bool
    var isTargeted: Bool
    var items: [AmountTagItem]
    var totalItemAmount: Double {
       return items.reduce(0.0) {$0 + $1.amount}
    }
    
    
}

extension Buddies {
    mutating func removeItem(at index: Int) {
        guard items.indices.contains(index) else {
            return
        }

        let itemAmount = items[index].amount
        amount -= itemAmount
        items.remove(at: index)
    }
}
extension Buddies {
    mutating func reduceQuantity(at index: Int) {
        guard items.indices.contains(index) else {
            return
        }

       items[index].quantity -= 1
    }
}


extension Buddies {
    static func buddiess() -> Buddies {
        return Buddies(name: "Chris", image: "chris", amount: 0.0, isSelected: false, isTargeted: false, items: [
            AmountTagItem(amount: 0.4, name: "Beer", quantity: 3),
            AmountTagItem(amount: 5.4, name: "Wine", quantity: 2),
            AmountTagItem(amount: 10.4, name: "Whisky", quantity: 4),
        ])
    }
}




struct AmountTagItem: Identifiable, Hashable, Codable, Transferable {
    var id = UUID()
    let amount: Double
    var name: String
    var quantity: Int
    var total: Double {
        return Double(quantity) * amount
    }
    
    
    func copy(amount: Double? = nil, name: String? = nil, quantity: Int? = nil) -> AmountTagItem {
        return AmountTagItem(
            id: self.id,
            amount: amount ?? self.amount,
            name: name ?? self.name,
            quantity: quantity ?? self.quantity
        )
    }
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .amountTag)
    }
}

extension UTType {
    static let amountTag = UTType(exportedAs: "com.david.Buddies")
    
}



