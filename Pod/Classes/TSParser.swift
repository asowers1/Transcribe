//
//  TSParser.swift
//  Pods
//
//  Created by Andrew Sowers on 2/29/16.
//
//

import Foundation

public class TSParser {
    
    public var strArr = [String]()
    
    public func acceptableTerminalChar(char:Character, nextChar: Character) -> Bool {
        let charAsStr = String(char)
        let nextCharAsStr = String(nextChar)
        switch charAsStr {
        case "<":
            switch nextCharAsStr {
            case "b": return true
            case "e": return true
            case "i": return true
            case "s": return true
            case "u": return true
            case "c": return true
            default: return false
            }
        case ">": return true
        case "/":
            switch nextCharAsStr {
            case "b": return true
            case "c": return true
            case "e": return true
            case "i": return true
            case "s": return true
            case "u": return true
            default: return true
            }
        case "a":
            switch nextCharAsStr {
            case "l": return true
            default: return false
            }
        case "b":
            switch nextCharAsStr {
            case ">": return true
            default: return false
            }
        case "c":
            switch nextCharAsStr {
            case "o": return true
            default: return false
            }
        case "e":
            switch nextCharAsStr {
            case ">": return true
            default: return false
            }
        case "i":
            switch nextCharAsStr {
            case ">": return true
            default: return false
            }
        case "l":
            switch nextCharAsStr {
            case "o": return true
            case "l": return true
            case ">": return true
            default: return false
            }
        case "o":
            switch nextCharAsStr {
            case "l": return true
            case "r": return true
            default: return false
            }
        case "s":
            switch nextCharAsStr {
            case "m": return true
            case ">": return true
            default: return false
            }
        case "u":
            switch nextCharAsStr {
            case ">": return true
            default: return false
            }
        default: return false
        }
    }

    
    public enum ReadingStates: String {
        case ReadingTerminal = "ReadingTerminal"
        case ReadingNonterminal = "ReadingNonterminal"
    }
    
    public func allowNPlusOne(index: Int, str: String) -> Bool {
        return index < str.characters.count ? true : false
    }

    public func lex(var currentAttribute: String, index: Int, source: String, state: ReadingStates, var currentLexeme: String? = nil) {
        if self.allowNPlusOne(index, str: source){
            currentAttribute += String(source[source.startIndex.advancedBy(index)])
        } else {
            return
        }
        switch state {
        case .ReadingNonterminal:
            
            if source[source.startIndex.advancedBy(index)] == "<" {
                if let _ = currentLexeme {
                    strArr.append(currentLexeme!)
                }
                lex(currentAttribute, index: index+1, source: source, state: .ReadingTerminal, currentLexeme: "<")
            } else {
                if let _ = currentLexeme {
                    currentLexeme = currentLexeme! + String(currentAttribute[currentAttribute.startIndex.advancedBy(index)])
                } else {
                    currentLexeme = String(currentAttribute[currentAttribute.startIndex.advancedBy(index)])
                }
                lex(currentAttribute, index: index+1, source: source, state: .ReadingNonterminal, currentLexeme: currentLexeme)
            }
            
        case .ReadingTerminal:
            if allowNPlusOne(index+1, str: source) {
                if acceptableTerminalChar(currentAttribute[currentAttribute.startIndex.advancedBy(index)], nextChar: source[source.startIndex.advancedBy(index+1)]) {
                    if let _ = currentLexeme {
                        currentLexeme = currentLexeme! + String(currentAttribute[currentAttribute.startIndex.advancedBy(index)])
                    } else {
                        currentLexeme = String(currentAttribute[currentAttribute.startIndex.advancedBy(index)])
                    }
                }
            } else {
                // done, so try and build the tree
                if source[source.startIndex.advancedBy(index)] == ">" {
                    if let _ = currentLexeme {
                        currentLexeme = currentLexeme! + ">"
                    }
                }
            }
            if source[source.startIndex.advancedBy(index)] == ">" {
                print(currentLexeme!)
                strArr.append(currentLexeme!)
                currentLexeme = nil
                lex(currentAttribute, index: index+1, source: source, state: .ReadingNonterminal, currentLexeme: currentLexeme)
            } else {
                lex(currentAttribute, index: index+1, source: source, state: .ReadingTerminal, currentLexeme: currentLexeme)
            }
            
        }
    }

}