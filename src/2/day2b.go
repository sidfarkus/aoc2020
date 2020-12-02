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
		
		index1, index2, letter, str := matches[1], matches[2], matches[3], matches[4]
		indexA, _ := strconv.Atoi(index1)
		indexB, _ := strconv.Atoi(index2)

		if (str[indexA - 1:indexA] == letter) != (str[indexB - 1:indexB] == letter) {
			valid++
		}
	}
	fmt.Println(valid)
}
