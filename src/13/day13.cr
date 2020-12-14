n, busses = File.read("input").split
schedule = busses.split(",").map {|x| x.to_i rescue 0}

def earliest_bus(start, schedule)
    b, m = schedule.select {|x| x > 0}.map {|b| {b, b - start % b} }.min_by {|b, m| m }
    b * m
end

# part 1
puts earliest_bus(n.to_i, schedule)

def pattern_match(start, schedule)
    schedule = schedule.map_with_index {|b,i| {b,i} }.select {|b,i| b > 0 }
    step = schedule.shift[0].to_i64

    # take steps of increasing size where the stepsize must be the lcm of the busses processed so far
    schedule.reduce(start - (start % step).to_i64) do |t, (bus, i)|
        until (t + i) % bus == 0
            t += step
        end
        step *= bus
        t
    end
end

# part 2
puts pattern_match(n.to_i64, schedule)