//
//  ContentView.swift
//  CarneNoPonto Watch App
//
//  Created by Yuri Cunha on 30/10/23.
//

import SwiftUI

struct ContentView: View {
    @State private var cookingTime: TimeInterval = 0
    @State private var grams: Int = 1
    @State private var meatDoneness: Double = 0.0
    @State private var selectedDoneness: MeatTemperature = .rare
    @State private var countDown: Timer?
    @State private var isUsingImages: Bool = false
    
    
    var body: some View {
        ScrollView {
            
            VStack(spacing: 22) {
                timer
                if isUsingImages {
                    visualAmount
                    visualDoneness
                } else {
                    amount
                    doneness
                }
                
                Toggle("imagens", isOn: $isUsingImages)
                
            }
            .padding()
        }
        .onChange(of: meatDoneness) { oldValue, newValue in
            selectedDoneness = MeatTemperature(rawValue: Int(newValue)) ?? .rare
        }
    }
    
    var timer: some View {
        VStack {
            Text(cookingTime.asTimeStamp)
            Button("Iniciar Timer") {
                countDown?.invalidate()
                cookingTime = selectedDoneness.cooktimeFor(kg: Double(grams)/10)
                countDown = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
                    cookingTime -= 1
                    if cookingTime == 0 {
                        timer.invalidate()
                    }
                })
            }
        }
    }
    
    var amount: some View {
        VStack(spacing: 8) {
            Text("Total: \(formatKg(grams))kg")
            HStack(spacing: 24) {
                Button {
                    grams -= 1
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.title)
                        .foregroundStyle(.blue)
                }
                .disabled(grams < 2)
                Button {
                    grams += 1
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                        .foregroundStyle(.blue)
                }
            }
            .buttonStyle(.plain)
        }
    }
    
    var doneness: some View {
        VStack {
            Text(selectedDoneness.stringValue)
            
            // o picker seria mais adequado, mas para utilizar mais componentes optamos pelo Slider
            Slider(value: $meatDoneness,in: 0...3,step: 1)
        }
    }
    
    var visualDoneness: some View {
        VStack(spacing: 0) {
            Text("Ponto da carne")
            
            Picker("Ponto da carne",selection: $meatDoneness) {
                ForEach(0..<4) { value in
                    HStack(spacing: 12) {
                        Image("temp-\(value + 1)")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 24)
                        
                        Text(MeatTemperature(rawValue: value)?.stringValue ?? "...")
                    }
                    .tag(Double(value))
                }
            }
            .frame(height: 60)
        }
    }
    
    var visualAmount: some View {
        VStack(spacing: 0) {
            Text("Total")
            Picker("",selection: $grams) {
                ForEach(1..<21) { value in
                    Text(formatKg(value) + " kg")
                        .tag(value)
                }
                
            }
            .frame(height: 100)
            .padding(.top,-8)
        }
    }
    
    private func formatKg(_ kg: Int) -> String {
        let double = (Double(kg)/10.0).rounded(1)
        return String(format: "%0.1f", double)
        
    }
}

#Preview {
    ContentView()
}

