
@restaurant = Restaurant.last

html_orig = File.open("/Users/srirachacha/Desktop/PROGRAMMING/RAILS/too_many_cooks/app/views/customers/order_confirmation.html.erb", "r") { |f| f.read }
erb = html_orig.dup

matches = erb.scan(/<%=(.*)%>/)
matches.each do |match|
  code_string = match.first
  pp "Finding match for: #{code_string}"
  evaled = eval(code_string)
  erb = erb.gsub("<%=#{code_string}%>", evaled.to_s)
end

