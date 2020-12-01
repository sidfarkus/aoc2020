puts inputtext.split("\n").map(&:to_i).combination(3).map {|nums| [nums.sum, nums.reduce(&:*)]}.find {|(sum, mult)| sum == 2020}
