//
//  HoroscopeViewModel.swift
//  Aztro Horoscope
//
//  Created by Ethan Rayala on 1/22/23.
//

import Foundation
import SwiftUI

import Foundation
import SwiftUI

// struct to store horoscope data
struct Horoscope: Codable {
    let date_range: String // date range for the horoscope
    let current_date: String // current date of horoscope
    let description: String // description of horoscope
    let compatibility: String // horoscope compatibility
    let mood: String // horoscope mood
    let color: String // horoscope color
    let lucky_number: String // horoscope lucky number
    let lucky_time: String // horoscope lucky time
}

class HoroscopeViewModel: ObservableObject {
    // private state variable to store user sign
    @State private var userSign = ""
    // private state variable to store selected day
    @State private var day = "today"

    // published variable to store the Horoscope data
    @Published var horoscope: Horoscope?
    
    // function to fetch horoscope data
    func fetchHoroscope(userSign: String, day: String) {
        // generate the url with the given user input of sign and day
        guard let url = URL(string: "https://aztro.sameerkumar.website/?sign=\(userSign)&day=\(day)") else {
            print("Invalid URL")
            return
        }

        // create a session and a request
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // create a data task to fetch data from the API
        let task = session.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            if let data = data {
                // decode the data into an instance of the "Horoscope" struct
                let decoder = JSONDecoder()
                do {
                    let horoscope = try decoder.decode(Horoscope.self, from: data)
                    DispatchQueue.main.async {
                        self.horoscope = horoscope
                    }
                } catch {
                    print("Error: \(error)")
                }
            }
        }
        task.resume()
    }
}
