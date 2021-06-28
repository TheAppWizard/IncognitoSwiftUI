//
//  ContentView.swift
//  IncognitoSwiftUI
//
//MARK:-  Created by Shreyas Vilaschandra Bhike on 28/06/21.
//MARK:-  The App Wizard
//MARK:- Instagram - theappwizard2408

import SwiftUI

struct ContentView: View {
    var body: some View {
        IncognitoView().edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


































//MARK:- MAIN CODE
struct IncognitoView: View {
    @State private var myButton = false
    
    
    var body: some View {
            ZStack{
                LinearGradient(Color.darkStart, Color.darkEnd)
              
                
                //Button
                Button(action: {
                self.myButton.toggle()
                }){
                   
                    Image("black")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                        .foregroundColor(.black)
                        .shadow(color: .darkEnd, radius: 5, x: 0, y: 0)
                 
                }
                .buttonStyle(DarkButton())
                    
                    
                    if myButton{
                        Image("glow")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                        .shadow(color: .blue, radius: 5, x: 0, y: 0)
                    }
              }
      }
    
}

//Color Extensions and Gradient
extension Color {
    static let darkStart = Color(red: 19 / 255, green: 95 / 255, blue: 154 / 255)
    static let darkEnd = Color(red: 8 / 255, green: 46 / 255, blue: 92 / 255)
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topTrailing, endPoint: .bottomTrailing)
    }
}

// DarkBackgroundButton and Shapes
struct DarkBackground<myShape: Shape>: View {
    var isTapped: Bool
    var shape: myShape

    var body: some View {
        ZStack {
            if isTapped {
                shape
                    .fill(LinearGradient(Color.darkEnd, Color.darkStart))
                      
                    .shadow(color: Color.darkStart, radius: 10, x: -5, y: -5)
                    .shadow(color: Color.darkEnd, radius: 10, x: -10, y: -10)
                
                   
                RingAnimation()
                WaveButton()
                
            } else {
                shape
                    .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                    
                    .shadow(color: Color.darkStart, radius: 10, x: -10, y: -10)
                    .shadow(color: Color.darkEnd, radius: 10, x: 10, y: 10)
                    
            }
        }
    }
}

struct DarkButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
    
        configuration.label
            .contentShape(Circle())
            .frame(width: 200, height: 200, alignment: .center)
            .background(
                DarkBackground(isTapped: configuration.isPressed, shape: Circle())
            )
        
      
       }
    }

//MARK:- WAVE ANIMATION
struct WaveButton: View {
    @State private var animationAmount : CGFloat = 1
    
    var body: some View {
        ZStack{
           Circle()
            .frame(width: 100, height: 100, alignment: .center)
            .padding(10)
            .foregroundColor(Color.clear)
            .clipShape(Circle())
            .overlay(Circle().stroke( LinearGradient(Color.darkStart, Color.darkEnd) , lineWidth: 3)
            .scaleEffect(animationAmount)
            .opacity(Double(2 - animationAmount))
            .animation(
                Animation.easeOut(duration: 1)
                    .repeatForever(autoreverses: false)
                )
            )
            .onAppear{ self.animationAmount = 2}
            
            Circle()
             .frame(width: 100, height: 100, alignment: .center)
             .padding(10)
             .foregroundColor(Color.clear)
             .clipShape(Circle())
             .overlay(Circle().stroke( LinearGradient(Color.darkStart, Color.darkEnd) , lineWidth: 3)
             .shadow(color: .blue, radius: 10, x: 0.0, y: 0.0)
             .scaleEffect(animationAmount)
             .opacity(Double(2 - animationAmount))
             .animation(
                 Animation.easeOut(duration: 1)
                     .repeatForever(autoreverses: false)
                 )
             )
                .onAppear{ self.animationAmount = 2}
            
            
            
            Circle()
             .frame(width: 100, height: 100, alignment: .center)
             .padding(10)
             .foregroundColor(Color.clear)
             .clipShape(Circle())
                .overlay(Circle().stroke( LinearGradient(Color.darkStart, Color.darkEnd) , lineWidth: 3)
             .scaleEffect(animationAmount)
             .opacity(Double(2 - animationAmount))
             .animation(
                 Animation.easeOut(duration: 1)
                     .repeatForever(autoreverses: false)
                 )
             )
             .onAppear{ self.animationAmount = 2}
            
        }
    }
}



struct RingAnimation: View {
    @State private var border : CGFloat = 0.0
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    var body: some View {
      
        ZStack{
            
            Circle()
                .trim( from: 0, to: self.border)
                .stroke(Color.white, lineWidth: 3)
                .frame(width: 220, height: 220, alignment: .center)
                .rotationEffect(.degrees(-90))
                            .onReceive(timer) { _ in
                                withAnimation {
                                    guard self.border < 1 else { return }
                                    self.border += 1
                                }
                        }
        }
    }
}
