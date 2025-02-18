//  JSONStructures.swift : support structures for JSON parsing
//  Traces
//  Created by Dario Crippa on 17/02/25

import Foundation

// Represents a parsed letter of the alphabet
struct ParsedLetter : Decodable, Identifiable, Hashable {
    let id : UUID = UUID()
    var emoji : String
    var letter : String
    var word : String
    
    enum CodingKeys: CodingKey {
        case emoji
        case letter
        case word
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.emoji = try container.decode(String.self, forKey: .emoji)
        self.letter = try container.decode(String.self, forKey: .letter)
        self.word = try container.decode(String.self, forKey: .word)
    }
    
    // Mock initializer
    init () {
        self.emoji = "❓"
        self.letter = String()
        self.word = "Missing"
    }
}

// Parses the content of the JSON file that contains the alphabet information
func parseAlphabetJSON(fileName : String) -> [ParsedLetter]? {
    let jsonDecoder = JSONDecoder()
    guard let dataURL = Bundle.main.url(forResource: fileName, withExtension: "json"),
          let fileData = try? Data(contentsOf: dataURL),
          let parsedAlphabet = try? jsonDecoder.decode([ParsedLetter].self, from: fileData)
    else {
        debugPrint("Something went wrong with the JSON decoding process 🔥")
        return nil
    }
    return parsedAlphabet
}
