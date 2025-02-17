//  JSONStructures.swift : support structures for JSON parsing
//  Traces
//  Created by Dario Crippa on 17/02/25

import Foundation

// Details regarding a letter of the alphabet
struct LetterJSON : Decodable, Identifiable, Hashable {
    let id : UUID = UUID()
    var letter : String
    var word : String
    var emoji : String
    
    enum CodingKeys: CodingKey {
        case letter
        case word
        case emoji
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.emoji = try container.decode(String.self, forKey: .emoji)
        self.letter = try container.decode(String.self, forKey: .letter)
        self.word = try container.decode(String.self, forKey: .word)
    }
    
    // Mock initializer -> used when the JSON decoding process fails
    init () {
        self.emoji = "🔥"
        self.letter = "?"
        self.word = "Error"
    }
}

// Parses and decodes the JSON content from the file that contains the alphabet information
func parseLetterJSON(fileName : String) -> [LetterJSON]? {
    let jsonDecoder = JSONDecoder()
    guard let dataURL = Bundle.main.url(forResource: fileName, withExtension: "json"),
          let fileData = try? Data(contentsOf: dataURL),
          let parsedInformation = try? jsonDecoder.decode([LetterJSON].self, from: fileData)
    else {
        debugPrint("Something went wrong with the JSON decoding process 🔥")
        return nil
    }
    return parsedInformation
}
