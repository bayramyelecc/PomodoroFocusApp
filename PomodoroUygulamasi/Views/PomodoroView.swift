//
//  PomodoroView.swift
//  PomodoroUygulamasi
//
//  Created by Bayram Yeleç on 28.08.2024.
//

import SwiftUI

struct PomodoroView: View {
    
    @StateObject var viewModel = PomodoroViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                ZStack{
                    Circle()
                        .stroke(lineWidth: 15)
                        .opacity(0.3) //
                        .foregroundColor(.gray)
                        .padding(.all, 50)

                    Circle()
                        .trim(from: 0.0, to: CGFloat(progress()))
                        .stroke(style: StrokeStyle(
                            lineWidth: 15,
                            lineCap: .round,
                            lineJoin: .round
                        ))
                        .foregroundColor(.black.opacity(0.8))
                        .rotationEffect(Angle(degrees: 270.0))
                        .animation(.easeInOut(duration: 0.5), value: progress())
                        .padding(.all, 50)
                    Text(timeString(from: viewModel.timer.remainingTime))
                        .font(.largeTitle)
                        .bold()
                }
                
                Divider()
                
                HStack{
                    Picker("Work Time", selection: $viewModel.timer.workTime) {
                        ForEach(1..<61){ minute in
                            Text("\(minute) min").tag(minute)
                        }
                    }
                    .frame(width: 170, height: 100)
                    .pickerStyle(WheelPickerStyle())
                    .onChange(of: viewModel.timer.workTime) { _, newValue in
                        viewModel.setWorkDuration(newValue)
                    }
                    
                    Spacer()

                    Picker("Break Time", selection: $viewModel.timer.breakTime) {
                        ForEach(1..<31){minute in
                            Text("\(minute) min").tag(minute)
                        }
                    }
                    .frame(width: 170, height: 100)
                    .pickerStyle(WheelPickerStyle())
                    .onChange(of: viewModel.timer.breakTime) { _, newValue in
                        viewModel.setBreakDuration(newValue)
                    }
                }
                .padding(.horizontal, 20)
                Spacer()
                HStack{
                    Button(action: {
                        if viewModel.timer.isRunning == true {
                            viewModel.stopTimer()
                        } else {
                            viewModel.startTimer()
                        }
                    }, label: {
                        Text(viewModel.timer.isRunning ? "Stop" : "Start")
                            .padding()
                            .font(.title)
                            .bold()
                            .background(.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.resetTimer()
                    }, label: {
                        Text("Reset")
                            .padding()
                            .font(.title)
                            .bold()
                            .background(.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    })
                }
                .padding(.horizontal, 60)
                Spacer()
                    .navigationTitle("Pomodoro Timer")
            }
        }
    }
    
    private func timeString(from time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let second = Int(time) % 60
        return String(format: "%02d:%02d", minutes, second)
    }
    
    private func progress() -> Double {
        let totalTime = viewModel.timer.isWorkTime ? TimeInterval(viewModel.timer.workTime * 60) : TimeInterval(viewModel.timer.breakTime * 60)
        return viewModel.timer.remainingTime / totalTime
    }
    
}

#Preview {
    PomodoroView()
}
