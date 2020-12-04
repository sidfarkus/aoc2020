const fs = require('fs')
const file = fs.readFileSync('input', 'utf-8').split("\n\n")

// part1
console.log(file.filter(p => p.trim().replace(/cid:\S+/, "").split(/\s+/).filter(f => f.length > 0).length === 7).length)

// part2
function rangeValid(min, max) {
    return s => parseInt(s) >= min && parseInt(s) <= max;
}
function validator(s) {
    return {
        byr: rangeValid(1920, 2002),
        iyr: rangeValid(2010, 2020),
        eyr: rangeValid(2020, 2030),
        hgt: x => x.endsWith("cm") ? rangeValid(150, 193)(x.slice(0, -2)) : rangeValid(59, 76)(x.slice(0, -2)),
        hcl: x => /#[0-9a-f]{6}/.test(x),
        ecl: x => "amb blu brn gry grn hzl oth".split(' ').includes(x),
        pid: x => x.length === 9,
        "": x => false
    }[s.slice(0, 3)](s.slice(4))
}
console.log(file.filter(p => p.trim().replace(/cid:\S+/, "").split(/\s+/).filter(validator).length === 7).length)
