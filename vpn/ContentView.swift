//
//  ContentView.swift
//  vpn
//
//  Created by Vitaliy Plaschenkov on 26.12.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
    }
}

struct HomeView: View {
    @State var showSideMenu = false
    @StateObject var speedSimulator = SpeedSimultor()
    var body: some View {
        ZStack{
            Color.appPrimary
                .ignoresSafeArea()
            
            VStack {
                
                TopMenuView(showSideMenu: $showSideMenu)
                SpeedTextView(speedSimulator: speedSimulator)
                Spacer()
                ProgressiveView(speedSimulator: speedSimulator)
                Spacer()
                Button(action: {
                    speedSimulator.startSpeedTest()
                    //start speed simul
                }, label: {
                    StartStopButtonView(speedSimulator: speedSimulator)
                })
                Spacer()
                
            }
            .padding(.horizontal)
            .foregroundColor(.white)
            
            VStack{
                Spacer()
                DropDownView()
                    .padding(.horizontal, 30)
            }
            
            if showSideMenu {
                SideMenuView(showSideMenu: $showSideMenu)
                    .foregroundColor(.white)
            }
        }
    }
}

struct TopMenuView: View {
    @Binding var showSideMenu: Bool
    var body: some View {
        HStack{
            Button(action: {
                showSideMenu = true
                 // show side menu
            }, label: {
                VStack{
                    HStack{
                        Circle()
                            .frame(width: 6, height: 6)
                        Circle()
                            .frame(width: 6, height: 6)
                    }
                    
                    HStack{
                        Circle()
                            .frame(width: 6, height: 6)
                        Circle()
                            .frame(width: 6, height: 6)
                    }
                }
    //            .foregroundColor(.white)
                .padding()
            })
            
            Text("Backyard")
                .font(.system(size: 18, weight: .black, design: .default))
            Text("VPN")
                .font(.system(size: 18, weight: .regular, design: .default))
            
            Spacer()
            
            PremiumView()
        }
    }
}

struct PremiumView: View{
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.darkPurple)
                .frame(width: 135, height: 40)
            HStack{
                Image(systemName: "flame.fill")
                Text("GO PREMIUM")
                    .font(.system(size: 12, weight: .regular))
            }
        }
    }
}

struct SpeedTextView: View {
    @ObservedObject var speedSimulator: SpeedSimultor
    var body: some View {
        VStack{
            Text(String(format: "%.2f", speedSimulator.calculatedSpeed))
                .font(.system(size: 40, weight: .semibold))
                .animation(.none)
            Text("mb/s")
                .font(.system(size: 16, weight: .light ))
        }
    }
}

struct ProgressiveView: View {
    @ObservedObject var speedSimulator: SpeedSimultor
    var body: some View {
        ZStack{
            Circle()
                .stroke(LinearGradient(gradient: Gradient(colors: [Color.progressBackground, Color.progressBackground.opacity(0.01)]), startPoint: .top, endPoint: .bottom), lineWidth: 24)
                .frame(width: 250, height: 250)
            
            Circle()
                .frame(width: 200, height: 200)
            
            ForEach(Array(stride(from: 0, through: 10, by: 1)), id: \.self) { i in
                Text("\(i * 10)")
                    .rotationEffect(.degrees(-120 - Double(i * 30)))
                    .offset(x: 160)
                    .rotationEffect(.degrees(Double(i * 30)))
            }
            .rotationEffect(.degrees(120))
            
            
            Circle()
                .trim(from: 0.1, to: speedSimulator.progress)
                .stroke(LinearGradient(gradient: Gradient(colors: [Color.progress, Color.progress.opacity(0.01)]),
                                       startPoint: .leading,
                                       endPoint: .trailing),
                        style: StrokeStyle(lineWidth: 24, lineCap: .round))
                .frame(width: 250, height: 250)
                .rotationEffect(.degrees(90))
        }
    }
}

struct StartStopButtonView: View {
    @ObservedObject var speedSimulator: SpeedSimultor
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .fill(speedSimulator.start ? Color.stopColor : Color.darkPurple)
                .frame(width: 110, height: 50)
            HStack{
                Image(systemName: "power")
                    .font(.system(size: 18, weight: .black))
                Text(speedSimulator.start ? "Stop" : "Start")
                    .font(.system(size: 18, weight: .regular))
            }
        }
    }
}

struct DropDownView: View {
    @StateObject var dropDownManager = DropDownManager()
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.dropDown)
                .frame(height: dropDownManager.expanded ? 300 : 60)
            HStack(alignment: .top){
                if !dropDownManager.expanded {
                    RegionItemView(region: dropDownManager.regions[dropDownManager.selectedIndex])
                        .onTapGesture {
                            withAnimation{dropDownManager.expandCollapseView() }
                        }
                } else {
                    VStack(spacing: 0){
                    ForEach(dropDownManager.regions) { region in
                        RegionItemView(region: region)
                            .onTapGesture {
                                withAnimation{dropDownManager.selectedItem(region: region)}
                            }
                    }
                    }
                }
                
                Image(systemName: "chevron.down")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .rotationEffect(dropDownManager.expanded  ? .degrees(180) : .zero)
                    .padding()
                    .padding(.top, 10)
                    .onTapGesture {
                        withAnimation{dropDownManager.expandCollapseView()}
                    }
            }
//            .padding()
        }
    }
}

struct RegionItemView: View {
    let region: Region
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white.opacity(0.01))
                .frame(height: 60)
            
            HStack(spacing: 16) {
                Text(region.imageName)
                    .font(.system(size: 55))
                    .fixedSize()
                    .frame(width: 30, height: 30)
                    .cornerRadius(15)
                
                Text(region.name)
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                ZStack(alignment: .leading){
                    HStack(spacing: 2){
                        ForEach(Array(stride(from: 0, to: 5, by: 1)), id: \.self) { _ in
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 6, height: 6)
                        }
                    }
                    
                    HStack(spacing: 2){
                        ForEach(Array(stride(from: 0, to: region.strenght, by: 1)), id: \.self) { _ in
                            Rectangle()
                                .fill(Color.green)
                                .frame(width: 6, height: 6)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}



extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let screenSize = UIScreen.main.bounds.size
}

extension Color {

    static let appPrimary = Color.init(red: 84/255, green: 31/255, blue: 221/255)
    static let dropDown = Color.init(red: 28/255, green: 24/255, blue: 197/255)
    static let progressBackground = Color.init(red: 149/255, green: 112/255, blue: 250/255)
    static let progress = Color.init(red: 252/255, green: 229/255, blue: 96/255)
    static let darkPurple = Color.init(red: 169/255, green: 41/255, blue: 246/255)
    static let viewTop = Color.init(red: 187/255, green: 68/255, blue: 251/255)
    static let viewBottom = Color.init(red: 104/255, green: 36/255, blue: 242/255)
    static let stopColor = Color.init(red: 250/255, green: 140/255, blue: 82/255)

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
