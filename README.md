# Get Rails Running:

1. `bundle`
2. `rake db:create && rake db:migrate`
3. `foreman start web`
4. check out: http://localhost:5000

# Run RSpec tests:

1. Make sure you have a "compatible" version of firefox (I'm using v. 40.0 on Mac, because it works: https://ftp.mozilla.org/pub/firefox/releases/40.0/mac/en-US/)
2. To run the entire test sutie: `foreman run rspec spec`
3. To run just models: `foreman run rspec spec/models`, or just feature specs: `foreman run rspec spec/features`, etc...
4. to run a specific test and optionally, the line: `foreman run rspec rspec/models/user_spec.rb:5`
