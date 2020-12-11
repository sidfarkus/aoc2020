import os
from itertools import product, permutations
from functools import reduce

def count_neighbors(seats, coord):
    return len([
        1 for check in product(*(range(n - 1, n + 2) for n in coord)) 
        if check != coord and 0 <= check[0] < len(seats[0]) and 0 <= check[1] < len(seats) and seats[check[1]][check[0]] == "#"
    ])

memo = {}
def count_visible_neighbors(seats, coord):
    def cast(origin, vec):
        x,y = (origin[0] + vec[0], origin[1] + vec[1])
        coords = []
        while 0 <= y < len(seats) and 0 <= x < len(seats[0]):
            coords.append((x, y))
            x, y = (x + vec[0], y + vec[1])
        return coords
    if not coord in memo:
        memo[coord] = [cast(coord, c) for c in product(range(-1, 2, 1), range(-1, 2, 1)) if c != (0,0)]
    return len([1 for c in memo[coord] if next((seats[y][x] for x,y in c if seats[y][x] != "."), ".") == "#"])

def simulate(text, crowd_limit=4, n_func=count_neighbors):
    next_state = [list(l) for l in text.splitlines()]
    last_state = [list("." * len(l)) for l in next_state]
    all_coords = list(product(range(len(next_state[0])), range(len(next_state))))
    while last_state != next_state:
        last_state, next_state = next_state, last_state
        for x,y in all_coords:
            val, neighbors = last_state[y][x], n_func(last_state, (x,y))
            next_state[y][x] = "#" if val == "L" and neighbors == 0 else ("L" if val == "#" and neighbors >= crowd_limit else val)
    return len([1 for z in [x for y in next_state for x in y] if z == "#"])

# Part 1
print(simulate(open("input").read()))

# Part 2
print(simulate(open("input").read(), crowd_limit=5, n_func=count_visible_neighbors))