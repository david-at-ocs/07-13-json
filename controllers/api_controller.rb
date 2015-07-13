# returns all assignments
get "/api/assignments" do
  @assignments = Assignment.all  
  json @assignments
end

# returns only information about the assignment with the given ID, but includes everything about it (including links to articles/videos and information about group members)
get "/api/assignments/:id" do
  
end

