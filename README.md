# README
file to understand how to run test cases and run the application

# Run the server

`rails server`

# Run in a browser

search the word odiseo in google

`http://localhost:3000/search_engine/index?search_engines=google&text=odiseo`

search the word odiseo in bing

`http://localhost:3000/search_engine/index?search_engines=bing&text=odiseo`

search the word odiseo in google and bing

`localhost:3000/search_engine/index?search_engines%5B%5D=google&search_engines%5B%5D=bing&text=odiseo`

# Execute default rails test cases
`bundle exec rake test test/controllers`

# Execute rspect test cases
`bundle exec rspec spec/services/`

I prefer working this way with rspec because, is easy create dummies,
the layer of services is disconnected from rails and that means the test cases
run very fast, here is a example execution 

`Finished in 8.94 seconds (files took 1.93 seconds to load)`

`3574 examples, 1 failure`

it takes less than 10 seconds to execute 3574 test cases

# No test case for adapter
is going to take me time to generate test cases for de search_engine because the 
result could vary and I dont have to much time to finish this assigment


