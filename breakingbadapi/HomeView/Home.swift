//
//  Home.swift
//  breakingbadapi
//
//  Created by Luciano Nicolini on 16/10/2022.
//

import SwiftUI

struct Home: View {
    @State private var quotes = [Quote]()
    
    var body: some View {
        NavigationStack {
            List(quotes, id: \.quote_id) { quote in
                VStack(alignment: .leading) {
                    Text(quote.author)
                        .foregroundColor(.blue)
                        .fontWeight(.medium)
                    Text(quote.quote)
                        
                }
            }
            .listStyle(.inset)
            .navigationTitle("BreakingBad")
            .task {
                await fetchData()
            }
        }
    }
        func fetchData() async {
            //create url
            guard let url = URL(string: "https://www.breakingbadapi.com/api/quotes") else {
                print("NOT WORK")
                return
            }
            // fetch data from that url
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let decodeResponse = try? JSONDecoder().decode([Quote].self, from: data) {
                    quotes = decodeResponse
                    
                }
            } catch {
                print("BAD NEWS")
            }
        }
    }
    
    
    struct Home_Previews: PreviewProvider {
        static var previews: some View {
            Home()
        }
    }
    
    struct Quote: Codable {
        
        internal init(quote_id: Int, quote: String, author: String, series: String) {
            self.quote_id = quote_id
            self.quote = quote
            self.author = author
            self.series = series
        }
        
        var quote_id: Int
        var quote: String
        var author: String
        var series: String
    }
    
    
