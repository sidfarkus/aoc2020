# reads direct from stdin/file so you need to comment out one of these to run the other
# part 1
$count = eval join '+',map{%h={};@h{split(//, s/\s//sgr)}=0;~~ keys %h;}split("\n\n",join("",<>));
print $count;

# part 2
$count = eval join '+',map{%h={};$s=$_;$h{$_}++ for split(//, s/\s//sgr);~~grep{$h{$_}==~~split(/\n/,$s)} keys %h;}split("\n\n",join("",<>));
print $count