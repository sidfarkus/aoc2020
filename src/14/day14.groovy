import java.util.regex.Matcher
def maskRegex = ~/mask = ([X01]+)/
def memRegex = ~/mem\[(\d+)\] = (\d+)/
def bMask = []
def memory = [:]

new File("input").eachLine { line ->
    switch (line) {
        case maskRegex:
            bMask = Matcher.lastMatcher.group(1).toList()
            break
        case memRegex:
            def (addr, val) = [1,2].collect { Long.parseLong(Matcher.lastMatcher.group(it)) }
            def bits = Long.toBinaryString(val).padLeft(36, "0").toList()
            val = Long.parseLong([bMask, bits].transpose().collect { mask,bit -> mask == "X" ? bit : mask }.join(""), 2)
            memory[addr] = val
    }
}
// part 1
println(memory.entrySet().collect { it.value }.sum())

memory = [:]
bMask = []
new File("input").eachLine { line ->
    switch (line) {
        case maskRegex:
            bMask = Matcher.lastMatcher.group(1).toList()
            break
        case memRegex:
            def (addr, val) = [1,2].collect { Long.parseLong(Matcher.lastMatcher.group(it)) }
            def addrBits = Long.toBinaryString(addr).padLeft(36, "0").toList()
            def allAddrs = [""]
            bMask.eachWithIndex {maskBit, i -> 
                allAddrs = allAddrs.collect { 
                    maskBit == "X" 
                        ? [it + "1", it + "0"] 
                        : (maskBit == "1" ? it + maskBit : it + addrBits[i])}.flatten()
            }
            allAddrs.each {
                memory[it] = val
            }
    }
}

// part 2
println(memory.entrySet().collect { it.value }.sum())