//
//  ContentView.swift
//  slots-challenge
//
//  Created by Daniel Mansour on 12/5/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var numCredits:Int = 1000
    @State private var slot1Val:Int = 0
    @State private var slot2Val:Int = 1
    @State private var slot3Val:Int = 2
    
    private let slotValDict:Dictionary<Int, String> = [
        0: "apple",
        1: "cherry",
        2: "star"
    ]
    private let losingRollCost:Int = -5
    private let winningRollEarnings:Int = 50
    private let defaultSlotImage:String = "apple"
    
    private var currentCreditsStr:String {
        return "Credits: \(numCredits)"
    }
    
    private var slot1Image:String {
        return slotValDict[slot1Val] ?? defaultSlotImage
    }
    
    private var slot2Image:String {
        return slotValDict[slot2Val] ?? defaultSlotImage
    }
    
    private var slot3Image:String {
        return slotValDict[slot3Val] ?? defaultSlotImage
    }
    
    var body: some View {
        VStack() {
            Text("SwiftUI Slots!")
                .font(.title)
            Spacer()
            Text(currentCreditsStr)
            Spacer()
            HStack() {
                Spacer()
                Image(slot1Image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
                Image(slot2Image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
                Image(slot3Image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
            }
            Spacer()
            Button {
                Spin()
            } label: {
                Text("Spin")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            }
                .padding(.horizontal, 40.0)
                .padding(.vertical)
                .background(.red)
                .cornerRadius(10.0)
            Spacer()
        }
    }
    
    private func Spin() -> Void {
        slot1Val = Roll3SidedDie()
        slot2Val = Roll3SidedDie()
        slot3Val = Roll3SidedDie()
        CalculateNumCredits()
    }
    
    private func Roll3SidedDie() -> Int {
        return Int.random(in: 0...2)
    }
    
    private func UserRolledWinner(roll1:Int, roll2:Int, roll3:Int) -> Bool {
        return roll1 == roll2 && roll2 == roll3
    }
    
    private func CalculateNumCredits() -> Void {
        numCredits += UserRolledWinner(roll1: slot1Val, roll2: slot2Val, roll3: slot3Val)
        ? winningRollEarnings
        : losingRollCost
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
