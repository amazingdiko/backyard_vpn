//
//  DataModel.swift
//  vpn
//
//  Created by Vitaliy Plaschenkov on 29.12.2022.
//

import Foundation
import SwiftUI

struct Region: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let strenght: Int
}

struct Data {
    static let region = [
    Region(name: "Russia", imageName: "🇷🇺", strenght: 5),
    Region(name: "USA", imageName: "🇺🇸", strenght: 1),
    Region(name: "Germany", imageName: "🇩🇪", strenght: 4),
    Region(name: "France", imageName: "🇫🇷", strenght: 3),
    Region(name: "Singapore", imageName: "🇸🇬", strenght: 2)
    ]
    
    static let menus = [
            MenuItem(name: "Apps using VPN", imageName: "icloud.and.arrow.down"),
            MenuItem(name: "Rate us", imageName: "star"),
            MenuItem(name: "Support", imageName: "questionmark.circle"),
            MenuItem(name: "Settings", imageName: "gearshape"),
        ]
}

struct MenuItem {
    let id = UUID()
    let name: String
    let imageName: String
}


class DropDownManager: ObservableObject {
    @Published var regions = Data.region
    @Published var expanded = false
    var selectedIndex = 0
    
    func expandCollapseView(){
        expanded.toggle()
    }
    
    func selectedItem(region: Region){
        if let index = regions.firstIndex(where: { $0.id == region.id }) {
            expandCollapseView()
            selectedIndex = index
        }
    }
}
