import scala.io.Source

val lines = Source.fromFile("input").getLines()
val containedParser = "(\\d+) (\\w+ \\w+) bags?,? ?".r
val bagParser = s"(\\w+ \\w+) bags contain (($containedParser)+|(no other bags)).".r

val bagMap = (for (line <- lines) yield line match {
    case bagParser(bagName, containableBags, _, _, _, _) => (bagName -> containableBags.split(", ").map { 
        case containedParser(num, bagName) => (num.toInt, bagName)
        case _ => (0, "")
    })
}).toMap

def delve(bag : String) : Int = bagMap.get(bag) match {
    case Some(children) if children.exists { case (_n : Int, b : String) => b == "shiny gold" } => 1
    case Some(children) => children.map { case (_n : Int, b : String) => delve(b)}.max
    case None => 0
}

def sumBags(bag : String) : Int = bagMap.get(bag) match {
    case Some(children) => children.map {case (n : Int, b : String) => n + n * sumBags(b)}.sum
    case None => 0
}

println(bagMap.keys.toList.map(delve _).sum)

println(sumBags("shiny gold"))