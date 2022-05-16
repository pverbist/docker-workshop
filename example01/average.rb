#!/usr/bin/env ruby
# Kimat's average ruby code
sum = 0
ARGV.each do |el|
  sum += el.to_i
end
p sum/ARGV.size.to_f
