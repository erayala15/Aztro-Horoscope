//
//  ContentView.swift
//  Aztro Horoscope
//
//  Created by Ethan Rayala on 1/22/23.
//

import SwiftUI

struct ContentView: View {
    // Array of zodiac signs
    let signs = ["aries", "taurus", "gemini", "cancer", "leo", "virgo", "libra", "scorpio", "sagittarius", "capricorn", "aquarius", "pisces"]
    // Array of days
    let days = ["today", "tomorrow", "yesterday"]

    // State variable to keep track of selected zodiac sign
    @State private var selectedSign = "aries"
    // State variable to keep track of selected day
    @State private var selectedDay = "today"
    // Observed object to handle fetching and displaying horoscope data
    @ObservedObject var viewModel = HoroscopeViewModel()
    // Linear gradient for background
    let gradient = LinearGradient(colors: [Color.purple, Color.pink],
                                  startPoint: .top, endPoint: .bottom)

    var body: some View {
        ZStack {
            // Set the background to the gradient
            gradient.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .center) {
                    // Title of the app
                    Text("Aztro Horoscope")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .opacity(0.95)
                        .padding(.bottom, 30)

                    VStack {
                        // Zodiac sign picker
                        HStack {
                            Text("Select your Sign:")
                            Picker("Select your Sign", selection: $selectedSign) {
                                ForEach(signs, id: \.self) {
                                    Text($0)
                                }
                            }
                        }
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.purple)
                        .padding(12)
                        .background(.white)
                        .cornerRadius(30)
                        
                        // Day picker
                        HStack {
                            Text("Select the Day:")
                            Picker("Select the Day", selection: $selectedDay) {
                                ForEach(days, id: \.self) {
                                    Text($0)
                                }
                            }
                        }
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.purple)
                        .padding(12)
                        .background(.white)
                        .cornerRadius(30)
                    }

                    // "Search" button to fetch horoscope data
                    Button("Search", action: {
                        viewModel.fetchHoroscope(userSign: selectedSign, day: selectedDay)
                    })
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(15)
                    .background(.pink)
                    .cornerRadius(30)
                    .padding(.bottom, 15)

                    HStack {
                        Text("Date:")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text(viewModel.horoscope?.current_date ?? "")
                            .font(.title3)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.bottom, 10)

                    HStack {
                        Text("Mood:")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text(viewModel.horoscope?.mood ?? "")
                            .font(.title3)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.bottom, 10)

                    HStack {
                        Text("Compatibility:")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text(viewModel.horoscope?.compatibility ?? "")
                            .font(.title3)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.bottom, 10)

                    HStack {
                        Text("Color:")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text(viewModel.horoscope?.color ?? "")
                            .font(.title3)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.bottom, 10)

                    HStack {
                        Text("Horoscope:")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Spacer()
                    }

                    Text(viewModel.horoscope?.description ?? "")
                        .font(.title3)
                        .foregroundColor(.white)
                }
                .padding(15)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
