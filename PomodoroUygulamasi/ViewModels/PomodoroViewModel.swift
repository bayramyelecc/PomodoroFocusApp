//
//  PomodoroViewModel.swift
//  PomodoroUygulamasi
//
//  Created by Bayram Yeleç on 28.08.2024.
//

import Foundation

class PomodoroViewModel : ObservableObject {
    
    @Published var timer = PomodoroModel(workTime: 25, breakTime: 5, remainingTime: 25 * 60, isRunning: false, isWorkTime: true)
    
    private var internalTimer: Timer?
    
    private let workTimesKey = "workTimes"
    private let breakTimesKey = "breakTimes"
    
    @Published var workTimes: [TimeInterval] = []
    @Published var breakTimes: [TimeInterval] = []
    
    init(){
        loadTimes()
    }
    
    func startTimer(){
        if !timer.isRunning {
            timer.isRunning = true
            
            internalTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
                self?.updateTimer()
            })
        }
    }
    
    func stopTimer() {
        timer.isRunning = false
        internalTimer?.invalidate()
    }
    
    func resetTimer(){
        stopTimer()
        timer.remainingTime = timer.isWorkTime ? TimeInterval(timer.workTime * 60) : TimeInterval(timer.breakTime * 60)
    }
    
    func updateTimer(){
        guard timer.isRunning else {return}
        
        if timer.remainingTime > 0 {
            timer.remainingTime -= 1
        } else {
            completeCycle()
            timer.isWorkTime.toggle()
            timer.remainingTime = timer.isWorkTime ? TimeInterval(timer.workTime * 60) : TimeInterval(timer.breakTime * 60)
        }
    }
    
    func setWorkDuration(_ duration: Int){
        timer.workTime = duration
        if timer.isWorkTime{
            resetTimer()
        }
    }
    
    func setBreakDuration(_ duration: Int){
        timer.breakTime = duration
        if !timer.isWorkTime {
            resetTimer()
        }
    }
    
    private func completeCycle() {
            let completedTime = timer.isWorkTime ? timer.workTime * 60 : timer.breakTime * 60
            if timer.isWorkTime {
                workTimes.append(TimeInterval(completedTime))
            } else {
                breakTimes.append(TimeInterval(completedTime))
            }
            saveTimes()
        }
    
    private func saveTimes() {
            UserDefaults.standard.set(workTimes, forKey: workTimesKey)
            UserDefaults.standard.set(breakTimes, forKey: breakTimesKey)
        }
    
    func loadTimes() {
            if let savedWorkTimes = UserDefaults.standard.array(forKey: workTimesKey) as? [TimeInterval] {
                workTimes = savedWorkTimes
            }
            if let savedBreakTimes = UserDefaults.standard.array(forKey: breakTimesKey) as? [TimeInterval] {
                breakTimes = savedBreakTimes
            }
        }
    
    func removeWorkTime(at offsets: IndexSet) {
            workTimes.remove(atOffsets: offsets)
            saveTimes()  // Update UserDefaults
        }
        
    func removeBreakTime(at offsets: IndexSet) {
            breakTimes.remove(atOffsets: offsets)
            saveTimes()  // Update UserDefaults
        }
    
}
