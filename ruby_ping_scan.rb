#!/usr/bin/ruby

machine_IP = '10.90.109.'

i=1

for i in 1..254
	@IP_addr_pinged = machine_IP + i.to_s
	puts @IP_addr_pinged
	i=i+1
end

