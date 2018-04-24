//: Playground - noun: a place where people can play

import UIKit

// String functions

// Quick Sort Algorithm
var dataArray : [Int] = [10,9,6,23,25,11,7]
let sortedArray : [Int] = []
var temp : Int = 0


for index in 0..<dataArray.count{

    let valueToCheck : Int = dataArray[index]
    
    for index1 in 0...index{
    
        let valueToCompare : Int = dataArray[index1]
        
        if valueToCheck <= valueToCompare{
            temp = dataArray[index]
            dataArray[index] = dataArray[index1]
            dataArray[index1] = temp
        }
    
    }

}
print(dataArray)

// Given number is prime number

let givenNumber = 789






























