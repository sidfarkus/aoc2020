// g++ day5.cxx -o day5 --std=c++11 && ./day5 "$(cat input)"

#include <iostream>
#include <bitset>
#include <sstream>
#include <string>
#include <algorithm>

int main(int argc, char ** argv) {
  std::string line;
  std::istringstream input(argv[1]);
  auto maxId = 0ul, minId = 99999ul, sum = 0ul;

  while (std::getline(input, line)) {
    std::bitset<8> row(line, 0, 7, 'F', 'B');
    std::bitset<8> col(line, 7, 3, 'L', 'R');
    auto id = row.to_ulong() * 8 + col.to_ulong();
    maxId = std::max(maxId, id);
    minId = std::min(minId, id);
    sum += id;
  }

  // ole gauss to the rescue
  auto missing = (minId + maxId) * (maxId - minId + 1) / 2 - sum;
  std::cout << maxId << std::endl << missing << std::endl;
  return 0;
}
