//: Playground - noun: a place where people can play

import UIKit

var sumOfTotalBalls = 0
var numberOfLayer = 10
var arrayOfRecoverBalls = [1,1,1,1,1,1,1,1,1,1]
var temp2 = 0

for(var i = 1 ; i <= numberOfLayer ; i++){

    
    var temp = 0
    temp = i*i
    sumOfTotalBalls += temp
    
    
    temp2 += arrayOfRecoverBalls[i-1]

}
temp2 = sumOfTotalBalls - temp2

print("Total number of Balls \(sumOfTotalBalls)")
print("Total number of Balls \(temp2)")
123