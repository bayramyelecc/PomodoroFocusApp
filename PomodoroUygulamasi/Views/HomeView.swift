//
//  HomeView.swift
//  PomodoroUygulamasi
//
//  Created by Bayram Yeleç on 28.08.2024.
//

import SwiftUI

struct HomeView: View {
    
    
    
    var body: some View {
            VStack{
                TabView{
                    
                    PomodoroView()
                        .tabItem {
                            Image(systemName: "timer")
                                .renderingMode(.template)
                                .foregroundColor(.blue)
                            Text("Pomodoro")
                        }.animation(.easeInOut, value: 1)
                    
                    ProfileView()
                        .tabItem {
                            Image(systemName: "list.clipboard")
                                .renderingMode(.template)
                                .foregroundColor(.green)
                            Text("Completed")
                                            }
                }
                .accentColor(.black)
            }
    }
}

#Preview {
    HomeView()
}
