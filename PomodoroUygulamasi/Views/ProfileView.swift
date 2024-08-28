//
//  ProfileView.swift
//  PomodoroUygulamasi
//
//  Created by Bayram Yeleç on 28.08.2024.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = PomodoroViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                List {
                    Section(header: Text("Work Completed")) {
                        ForEach(viewModel.workTimes, id: \.self) { time in
                            Text("\(Int(time) / 60) dakika \(Int(time) % 60) saniye")
                                .font(.headline)
                                .bold()
                        }
                        .onDelete(perform: viewModel.removeWorkTime)
                    }
                }
                
                List{
                    
                    Section(header: Text("Break Completed")) {
                        ForEach(viewModel.breakTimes, id: \.self) { time in
                            Text("\(Int(time) / 60) dakika \(Int(time) % 60) saniye")
                                .font(.headline)
                                .bold()
                        }
                        .onDelete(perform: viewModel.removeBreakTime)
                        }
                    
                }
            }
            .background(.gray.opacity(0.115))
            .navigationTitle("Completed")
            .onAppear{
                viewModel.loadTimes()
            }
        }
    }
}

#Preview {
    ProfileView()
}
