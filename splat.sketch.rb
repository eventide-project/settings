def foo(*args)
  args.each { |a| puts "#{a}: #{a.class}" }
end

a = *[:a, :b, :c]
foo a


puts 'Atomic args:'
foo :a, :b, :c

puts 'Array args:'
foo [:a, :b, :c]

puts 'Single atomic arg:'
foo :a

puts 'Single array arg:'
foo [:a]

