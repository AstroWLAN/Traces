//  JSONStructures.swift
//  Traces
//  Created by Dario Crippa on 17/02/25

import Foundation

// Encapsulates an alphabet letter after parsing
struct LetterJSON : Decodable, Identifiable, Hashable {
    let id : UUID = UUID()
    var letter : String
    var word : String
    
    enum CodingKeys: CodingKey {
        case letter
        case word
    }
    
    init(from decoder: Decoder) throws {
        // Initializer
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.letter = try container.decode(String.self, forKey: .letter)
        self.word = try container.decode(String.self, forKey: .word)
    }
    
    init () {
        // Mock initialization
        self.letter = "?"
        self.word = "Missing"
    }
}

// Reads and parses alphabet details from 'alphabet.json'
func parseAlphabetJSON(fileName : String) -> [LetterJSON]? {
    let jsonDecoder = JSONDecoder()
    guard let dataURL = Bundle.main.url(forResource: fileName, withExtension: "json"),
          let fileData = try? Data(contentsOf: dataURL),
          let parsedAlphabet = try? jsonDecoder.decode([LetterJSON].self, from: fileData)
    else {
        debugPrint("Something went wrong with the JSON decoding process 🔥")
        return nil
    }
    return parsedAlphabet
}

// Encapsulates a parsed paragraph derived from the research underpinning this application
struct ResearchParagraphJSON : Decodable, Identifiable, Hashable {
    let id : UUID = UUID()
    var title : String
    var content : String
    
    enum CodingKeys: CodingKey {
        case title
        case content
    }
    
    init(from decoder: Decoder) throws {
        // Initializer
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.content = try container.decode(String.self, forKey: .content)
    }

    init () {
        // Mock initialization
        self.title = "Unknown"
        self.content = "Missing"
    }
}

// Reads and parses research details from 'research.json'
func parseResearchParagraphJSON(fileName : String) -> [ResearchParagraphJSON]? {
    let jsonDecoder = JSONDecoder()
    guard let dataURL = Bundle.main.url(forResource: fileName, withExtension: "json"),
          let fileData = try? Data(contentsOf: dataURL),
          let parsedResearchParagraphs = try? jsonDecoder.decode([ResearchParagraphJSON].self, from: fileData)
    else {
        debugPrint("Something went wrong with the JSON decoding process 🔥")
        return nil
    }
    return parsedResearchParagraphs
}

// Encapsulates parsed information about the third-party resources integrated into this application
struct ResourceJSON : Decodable, Identifiable, Hashable {
    let id : UUID = UUID()
    var name : String
    var source : String
    var description : String
    
    enum CodingKeys: CodingKey {
        case name
        case source
        case description
    }
    
    init(from decoder: Decoder) throws {
        // Initializer
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.source = try container.decode(String.self, forKey: .source)
        self.description = try container.decode(String.self, forKey: .description)
    }
    
    init () {
        // Mock initialization
        self.name = "Missing"
        self.source = "Unknown"
        self.description = "Something went wrong with the JSON decoding process 🔥"
    }
}

// Reads and parses resource information from 'resources.json'
func parseResourcesJSON(fileName : String) -> [ResourceJSON]? {
    let jsonDecoder = JSONDecoder()
    guard let dataURL = Bundle.main.url(forResource: fileName, withExtension: "json"),
          let fileData = try? Data(contentsOf: dataURL),
          let parsedResources = try? jsonDecoder.decode([ResourceJSON].self, from: fileData)
    else {
        debugPrint("Something went wrong with the JSON decoding process 🔥")
        return nil
    }
    return parsedResources
}

// Encapsulates parsed information displayed on the app's splash screen
struct SplashJSON : Decodable, Identifiable, Hashable {
    let id : UUID = UUID()
    var symbol : String
    var title : String
    var description : String
    
    enum CodingKeys: CodingKey {
        case symbol
        case title
        case description
    }
    
    init(from decoder: Decoder) throws {
        // Initializer
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
    }
    
    init () {
        // Mock initialization
        self.symbol = "questionmark.diamond.fill"
        self.title = "Missing"
        self.description = "Something went wrong with the JSON decoding process 🔥"
    }
}

// Reads and parses splash screen data from 'splash.json'
func parseSplashJSON(fileName : String) -> [SplashJSON]? {
    let jsonDecoder = JSONDecoder()
    guard let dataURL = Bundle.main.url(forResource: fileName, withExtension: "json"),
          let fileData = try? Data(contentsOf: dataURL),
          let parsedSplashInformation = try? jsonDecoder.decode([SplashJSON].self, from: fileData)
    else {
        debugPrint("Something went wrong with the JSON decoding process 🔥")
        return nil
    }
    return parsedSplashInformation
}
