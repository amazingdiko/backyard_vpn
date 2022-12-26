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
    var body: some View {
        ZStack{
            Color.appPrimary
                .ignoresSafeArea()
            
            VStack {
                
                TopMenuView()
                SpeedTextView()
                ProgressiveView()
                    .padding(.top, 80)
                StartStopButtonView()
                
            }
            .padding(.horizontal)
            .foregroundColor(.white)
        }
    }
}

struct SideMenuView: View {
    var body: some View {
        ZStack{
            
        }
    }
}

struct TopMenuView: View {
    var body: some View {
        HStack{
            Button(action: {
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
            
            Text("Abuser")
                .font(.system(size: 18, weight: .black, design: .default))
            Text("VPN")
                .font(.system(size: 18, weight: .regular, design: .default))
            
            Spacer()
            
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
}

struct SpeedTextView: View {
    var body: some View {
        VStack{
            Text("35.12")
                .font(.system(size: 40, weight: .semibold))
            Text("mb/s")
                .font(.system(size: 16, weight: .light ))
        }
    }
}

struct ProgressiveView: View {
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
                .trim(from: 0.1, to: 0.5)
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
    var body: some View {
        ZStack{
        }
    }
}

struct DropDownView: View {
    var body: some View {
        ZStack{
            
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
