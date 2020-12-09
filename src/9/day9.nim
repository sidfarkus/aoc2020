# nim r day9.nim

import sequtils, sugar
import system/io
import deques
import strutils

proc hasPairSum(nums: Deque[int64], sum: int64): bool =
    for i in 0..<nums.len:
        for j in 0..<nums.len:
            if i != j and nums[i] + nums[j] == sum: return true
    false

var nums = initDeque[int64]()
var window = initDeque[int64]()
var goal: int64 = 0

for line in "input".lines:
    var num = parseBiggestInt(line)
    nums.addLast(num)
    if window.len < 25:
        window.addLast(num)
    elif hasPairSum(window, num):
        window.addLast(num)
        window.popFirst()
    else:
        goal = num
        echo(num)
        break

# slide a window of increasing size over the candidates
var candidates = toSeq(nums).filter(l => l < goal)
for windowSize in 2..candidates.len:
    for i in 0..<(candidates.len - windowSize):
        var windowRange = i..<(i + windowSize)
        var slice = candidates[windowRange]
        var sum = foldl(slice, a + b)
        if sum == goal:
            echo(slice.max() + slice.min())
