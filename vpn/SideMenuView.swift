//
//  SideMenuView.swift
//  vpn
//
//  Created by Vitaliy Plaschenkov on 29.12.2022.
//

import SwiftUI

struct SideMenuView: View {
    @State var startAnimation = false
    @Binding var showSideMenu: Bool
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.black.opacity(0.1))
                .ignoresSafeArea()
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.purple)
                .rotationEffect(startAnimation ? .degrees(15) : .zero, anchor: .bottomTrailing)
                .offset(x: startAnimation ? -UIScreen.screenWidth/2 : -UIScreen.screenWidth, y: 20)
                .scaleEffect(0.95)
            
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.purple)
                .rotationEffect(startAnimation ? .degrees(10): .zero, anchor: .bottomTrailing)
                .offset(x: startAnimation ? -UIScreen.screenWidth/2 : -UIScreen.screenWidth, y: 20)
                .scaleEffect(0.85)
                .shadow(color: .black, radius: 10)
            
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    Spacer()
                    HStack{
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                startAnimation.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    showSideMenu = false
                                }
                            }
                        }, label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 20, weight: .bold))
                                .padding()
                        })
                    }
                    .offset(x: -UIScreen.screenWidth/4)
                
                Spacer()
                UserView()
                Spacer()
                
                MenuListView()
                    
                Spacer(minLength: 200)
                }
                .padding(.horizontal)
                .offset(x: startAnimation ? 0.0 : -UIScreen.screenWidth)
        }
            .onAppear {
                withAnimation {
                    startAnimation.toggle()
                }
            }
    }
}

struct UserView: View {
    var body: some View {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 70, height: 70)
            
            Text("Hello,")
            Text("Vitaliy Plaschenkov")
                .bold()
        }
    }
}

struct MenuItemView: View {
    let menu: MenuItem
    var body: some View {
        HStack(spacing: 14){
            Image(systemName: menu.imageName)
                .fixedSize(horizontal: true, vertical: true)
                .frame(width: 20)
            Text(menu.name)
                .padding(.vertical, 8)
                .font(.system(size: 14, weight: .bold))
        }
        .foregroundColor(.white)
    }
}

struct MenuListView: View {
    var body: some View {
            ForEach(Data.menus) { menu in
                MenuItemView(menu: menu)
        }
    }
}
