//
//  Home.swift
//  Twitter_Profile_Demo
//
//  Created by vignesh kumar c on 08/09/23.
//

import Foundation
import SwiftUI

struct Home: View {
    
    @State var offset: CGFloat = 0
    @State var currentTab: String = "Posts"
    
    @State var tabBarOffset: CGFloat = 0
    
    var tweetContent: [tweetModel] = [
        tweetModel(content: "hdsbewbfewfhwebfwf", tweetImage: "tweet1"),
        tweetModel(content: "jdvioefnerbgekfejnfwe", tweetImage: "tweet2"),
        tweetModel(content: "ejfnefbefhebhfebfwehf", tweetImage: "tweet3"),
        tweetModel(content: "hbfwebfwenfwefjewfwef", tweetImage: "tweet4"),
        tweetModel(content: "hefbwefbwehfbfwhfbwjdq", tweetImage: "tweet5")]
    
    var tweets: [String] = [
        "sfnergerfn oifngerjnejofneofe", "wefhbefbjfefnwefwef", "hfebwbfehiifwf", "efhbweifbfbfns urebg dvhiuaergaefwfwf", "fherbjhvjbierbgbajfbnahkherg", "fqieajowubhfdvsjnaiwbhnsfeihbf",  "opiofb dkawkfeg svnergi sjafbherg ev"]
    var tweetImage: [String] = ["tweet1", "tweet2", "tweet3", "tweet4", "tweet5"]
    
    @Namespace var animation
    
    //For dark mode adoption
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content : {
            VStack(spacing: 15) {
                // header View
                GeometryReader { proxy -> AnyView in
                    
                    // sticky header view
                    
                    let minY = proxy.frame(in: .global).minY
                    
                    DispatchQueue.main.async {
                        self.offset = minY
                        print(minY)
                    }
                    
                    return AnyView(
                        ZStack {
                            Image("profile")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: getRect().width, height: minY > 0 ? 180 + minY : 180, alignment: .center)
                                .cornerRadius(0)
                            BlurView()
                                .opacity(blurViewOpacity())
                            
                        }
                         // .frame(height: minY > 0 ? 180 + minY : nil)
                            .offset(y: minY > 0 ? -minY : -minY < 80 ? 0 : -minY - 80)
                    )
                    
                }
                .frame(height: 180)
                .zIndex(1)
                //profile Image
                
                VStack {
                    HStack {
                        Image("profile")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 75, height: 75)
                            .clipShape(Circle())
                            .padding(8)
                            .background(colorScheme == .dark ? Color.black : Color.white)
                            .clipShape(Circle())
                            .offset(y: offset < 0 ? getOffset() - 20 : -20 )
                            .scaleEffect(getScale())
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("Edit Profile")
                                .foregroundColor(Color.red)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background(
                                    Capsule()
                                        .stroke(Color.red)
                                )
                        }

                    }
                    .padding(.top, -25)
                    .padding(.bottom, -15)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Virat")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        Text("@imVkohli")
                            .foregroundColor(.gray)
                        Text("I'm virat the leading run scorer in the history of cricket and i have a 50 plus average in all formats ")
                        
                        HStack(spacing: 5) {
                            Text("61")
                                .foregroundColor(.primary)
                                .fontWeight(.semibold)
                            Text("Following")
                                .foregroundColor(.gray)
                            Text("57.7M")
                                .foregroundColor(.primary)
                                .fontWeight(.semibold)
                                .padding(.leading, 10)
                            Text("Followers")
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 8)
                    }
                    
                    // custom segmented menu
                    
                    VStack(spacing: 0) {
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                TabButton(title: "Posts", currentTab: $currentTab, animation: animation)
                                TabButton(title: "Replies", currentTab: $currentTab, animation: animation)
                                TabButton(title: "Media", currentTab: $currentTab, animation: animation)
                                TabButton(title: "Likes", currentTab: $currentTab, animation: animation)
                            }
                        }
                        Divider()
                    }
                    .padding(.top, 30)
                    .background(Color.white)
                    .offset(y: tabBarOffset < 90 ? -tabBarOffset + 90 : 0)
                    .overlay(
                        GeometryReader { reader -> Color in
                            let minY = reader.frame(in: .global).minY
                            
                            DispatchQueue.main.async {
                                self.tabBarOffset = minY
                            }
                            return Color.clear
                        }
                        .frame(width: 0, height: 0)
                        ,alignment: .top
                    )
                    .zIndex(1)
                    VStack(spacing: 18) {
                        TweetsView(tweet: "Your wardrobe can be your canvas too. Own it.. Get the Wrogn AW'23 looks here #stayWrogn", twwtImage: "post")
                        Divider()
                           
                        ForEach(tweetContent, id: \.self) { tweets in
                            TweetsView(tweet: tweets.content, twwtImage: tweets.tweetImage)
                            Divider()
                        }
                    }
                    .padding(.top, 30)
                    .zIndex(0)
                }
                .padding(.horizontal)
                .zIndex(-offset > 80  ? 0 : 1)
            }
        })
       .ignoresSafeArea(.all, edges: .top)
    }
    
    func getOffset() -> CGFloat {
        let progress = (-offset / 80) * 20
        return progress <= 20 ? progress: 20
    }
    
    func getScale() -> CGFloat {
        let progress = -offset / 80
        
        let scale = 1.8 - (progress < 1.0 ? progress : 1)
        return scale < 1 ? scale : 1
    }
    
    func blurViewOpacity() -> Double {
        let progress = (-offset + 80) / 180
        
        return Double(-offset > 80 ? progress : 0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct TabButton: View {
    var title: String
    @Binding var currentTab: String
    var animation: Namespace.ID
    
    var body: some View {
        
        Button(action: {
              withAnimation {
                  currentTab = title
              }
          }, label: {
            LazyVStack(spacing: 12) {
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(currentTab == title ? .blue : .gray)
                    .padding(.horizontal)
                
                if currentTab == title {
                    Capsule()
                        .fill(Color.blue)
                        .frame(height: 1.2)
                        .matchedGeometryEffect(id: "TAB", in: animation)
                } else {
                    Capsule()
                        .fill(Color.clear)
                        .frame(height: 1.2)
                }
            }
        })

    }
}

struct ImagePreviewView: View {
    var imageName: String
    
    var body: some View {
        NavigationLink(destination: FullScreenImageView(imageName: imageName)) {
            Image(imageName)
                .resizable()
                .scaledToFit()
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct FullScreenImageView: View {
    var imageName: String
    
    var body: some View {
        GeometryReader { geometry in
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct TweetsView: View {
    var tweet: String
    var twwtImage: String?

    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image("profile")
                .resizable()
                .aspectRatio( contentMode: .fill)
                .frame(width: 55, height: 55)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 8) {
                (
                    Text("Virat Kohli ")
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    +
                    Text("@imVkohli.2h")
                        .foregroundColor(.gray)
                )
                Text(tweet)
                    .frame(maxHeight: 100, alignment: .top)
                
                // Your wardrobe can be your canvas too. Own it.. Get the Wrogn AW'23 looks here #stayWrogn
                if let image = twwtImage {
                    GeometryReader{ proxy in
                        HStack {
                            //                                        NavigationView {
                            //                                            ImagePreviewView(imageName: "post")
                            //                                        }
                            Image(image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: proxy.frame(in: .global).width / 2 , height: 310)
                                .cornerRadius(15)
                            
                            
                            VStack(spacing: 0) {
                                Image(image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: proxy.frame(in: .global).width / 2, height: 150)
                                    .cornerRadius(15)
                                Image(image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: proxy.frame(in: .global).width / 2, height: 150)
                                    .cornerRadius(15)
                            }
                        }
                    }
                    .frame(height: 300)
                }
                
            }
        }
    }
}

struct tweetModel: Hashable {
    var content: String
    var tweetImage: String
}
