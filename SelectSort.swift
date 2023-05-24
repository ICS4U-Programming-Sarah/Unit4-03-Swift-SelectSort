// This program reads information from file, 
// it then sorts using selection sort.

//
//  Created by Sarah Andrew

//  Created on 2023-03-22.

//  Version 1.0

//  Copyright (c) 2023 Sarah. All rights reserved.
import Foundation

import Foundation

// This function calculates the mean.
func selectSort(_ arrayNums: [Int]) -> [Int] {
    var sortedNums = arrayNums
    // If statement, returning empty array 
    // to avoid out of bounds error. 
    if sortedNums.count < 2 {
        return sortedNums
    }
    // Usage of loop to access each element.
    for counter1 in 0..<sortedNums.count {
        // Declare variable. 
        var minNum = counter1;
        
        // Usage of loop that checks if current is bigger than
        // previous, switching positions if so, to sorted.
        for counter2 in (counter1 + 1)..<sortedNums.count {
            if sortedNums[counter2] < sortedNums[minNum] {
                minNum = counter2
            }
        }
        // Checking the min num in the loop.
        if minNum != counter1 {
            // Declare variable.
            let temp = sortedNums[counter1]
            // Using temp to swap.
            sortedNums[counter1] = sortedNums[minNum]
            sortedNums[minNum] = temp
        }
    
    }
    return sortedNums
}

// Define input & output paths.
let inputFile = "input.txt"
let outputFile = "output.txt"

// Usage of file handle method to locate files,
// as well as opening input for file reading.
do {
    // Open input file for reading.
    guard let input = FileHandle(forReadingAtPath: inputFile) else {
        print("Error: cannot access input file for opening.")
        exit(1)
    }

    // Open output file for writing.
    guard let output = FileHandle(forWritingAtPath: outputFile) else {
        print("Error: cannot access output file for opening.")
        exit(1)
    }

    // Read context for file.
    let inputData = input.readDataToEndOfFile()

    // Convert data to a string.
    guard let inputString = String(data: inputData, encoding: .utf8) else {
        print("Error: Cannot convert input data to string.")
        exit(1)
    }

    // Split string into lines, ensuring reading empty line
    // also creating list.
    let inputLines = inputString.components(separatedBy: .newlines)

    // Convert from string of list to array of integers
    // & check for blank lines.
    for line in inputLines {
        if line.isEmpty {
            print("No integers found on line.")
            let data4 = Data("No integers found on line.\n".utf8)
            output.write(data4)
            continue
        }
        
        var intArray: [Int] = []
        let numberStrings = line.components(separatedBy: " ")
        
        // Checking to see if array contains blank line.
        if numberStrings.isEmpty {
            print("No integers found on line.")
            let data5 = Data("No integers found on line.\n".utf8)
            output.write(data5)
            continue
        }

        // Convert from string to integer & check for invalid input.
        for str in numberStrings {
            if let intValue = Int(str) {
                intArray.append(intValue)
            } else {
                print("Invalid input: '\(str)' is not a valid integer")
                let data5 = Data("Invalid input: '\(str)' is not a valid integer\n".utf8)
                output.write(data5)
                break
            }
        }
        
        // Sort the integer array.
        let sortSelect = selectSort(intArray)
        
        // Display to user.
        print(sortSelect)
        
        // Write to file.
        let data3 = Data("The sorted array is:  \(sortSelect)\n".utf8)
        output.write(data3)
    }

    // Close input & output file.
    input.closeFile()
    output.closeFile()
}