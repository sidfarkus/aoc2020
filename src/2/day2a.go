package main

import (
	"fmt"
	"io/ioutil"
	"regexp"
	"strings"
	"strconv"
)

func main() {
	input, _ := ioutil.ReadFile("input")
	inputStr := string(input)
	valid := 0
	for _, line := range strings.Split(inputStr, "\n") {
		re, _ := regexp.Compile(`(\d+)-(\d+) ([a-z]): (\w+)`)
		matches := re.FindStringSubmatch(line)
		if len(matches) == 0 {
			break
		}
		min, max, letter, str := matches[1], matches[2], matches[3], matches[4]
		minBound, _ := strconv.Atoi(min)
		maxBound, _ := strconv.Atoi(max)
		occurrences := strings.Count(str, letter)

		if occurrences >= minBound && occurrences <= maxBound {
			valid++
		}
	}
	fmt.Println(valid)
}
