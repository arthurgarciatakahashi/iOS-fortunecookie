//
//  ContentView.swift
//  fortunecookie
//
//  Created by arthur takahashi on 03/08/20.
//  Copyright © 2020 Arthur Takahashi. All rights reserved.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var cookieMessage :String = "Please wait..."
    @State var change = true

    let host: String = "http://yerkee.com/api/fortune/all"
    let imageName = "pic-fortune-cookie-1"

    struct FortuneResponse : Codable {
        var fortune : String
    }

    var body: some View {
        VStack {
            Spacer()
                if self.change {
                    Image(self.imageName)
                        .transition(AnyTransition.slide)
                        .animation(.default)
                } else {
                    //TODO: Bug padding ScrollView layout priority
                        ScrollView {
                            Text(cookieMessage).onAppear(perform: getJson)
                            .padding()
                            .border(Color.white, width: 4)
                            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 1.0)))
                            .animation(.linear)
                            .foregroundColor(.white)
                                .scaledFont(name: "Georgia", size: getPerfetcFontSize())
                            .lineLimit(nil)
                    }.padding()
                }
            
            Spacer()
            
            Button(self.getTextButton()) {
                if self.change {
                    playSound(name: "bone-crack-1", fileType: "wav")
                }
                self.change.toggle()
            }.foregroundColor(.white)
            .padding()
            .background(Color.accentColor)
            .cornerRadius(11)

            Spacer()
        }.frame(minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
        ).background(Color.black)
    }
    
    func getPerfetcFontSize() -> CGFloat {
        return 28
    }
    
    func getTextButton() -> String {
        return change ? "GET A FREE COOKIE" : "BACK"
    }
    
    func getJson() {
        guard let url = URL(string: self.host) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                if let decodedData = try? JSONDecoder().decode(FortuneResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.cookieMessage = decodedData.fortune
                    }
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")

        }.resume()
    }
}

struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: CGFloat

    func body(content: Content) -> some View {
       let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name, size: scaledSize))
    }
}

extension View {
func scaledFont(name: String, size: CGFloat) -> some View {
    return self.modifier(ScaledFont(name: name, size: size))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
