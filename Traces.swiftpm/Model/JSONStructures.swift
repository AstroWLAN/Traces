//  JSONStructures.swift : support structures for JSON parsing
//  Traces
//  Created by Dario Crippa on 17/02/25

import Foundation

// Represents a parsed letter of the alphabet
struct ParsedLetter : Decodable, Identifiable, Hashable {
    let id : UUID = UUID()
    var letter : String
    var word : String
    
    enum CodingKeys: CodingKey {
        case letter
        case word
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.letter = try container.decode(String.self, forKey: .letter)
        self.word = try container.decode(String.self, forKey: .word)
    }
    
    // Mock initializer
    init () {
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

// Represents a parsed letter of the alphabet
struct ParsedParagraph : Decodable, Identifiable, Hashable {
    let id : UUID = UUID()
    var paragraph : String
    var content : String
    
    enum CodingKeys: CodingKey {
        case paragraph
        case content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.paragraph = try container.decode(String.self, forKey: .paragraph)
        self.content = try container.decode(String.self, forKey: .content)
    }
    
    // Mock initializer
    init () {
        self.paragraph = "Unkown"
        self.content = "Missing content"
    }
}

// Parses the content of the JSON file that contains the alphabet information
func parseParagraphsJSON(fileName : String) -> [ParsedParagraph]? {
    let jsonDecoder = JSONDecoder()
    guard let dataURL = Bundle.main.url(forResource: fileName, withExtension: "json"),
          let fileData = try? Data(contentsOf: dataURL),
          let parsedParagraphs = try? jsonDecoder.decode([ParsedParagraph].self, from: fileData)
    else {
        debugPrint("Something went wrong with the JSON decoding process 🔥")
        return nil
    }
    return parsedParagraphs
}
