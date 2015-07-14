# get "/" do
#   @assignments = Assignment.all
#   json @assignments
# end

# get "/" do
#   erb :"main/home"
# end

get "/api/assignments" do
  @assignments = Assignment.all
  json @assignments
end

get "/api/assignments/:id" do
  id = params["id"].to_i
  @assignment = Assignment.find(id).to_hash
  json @assignment
end

get "/api/assignment_links/:id" do
  id = params["id"].to_i
  @resource = Assignment.get_resources(id)
  json(@resource)
end

get "/api/new" do
  @new_assignment = Assignment.new({"title" => "new_assignment", "description" => "this is a description", "github_link" => "http://www.google.com"})
  # @new_assignment.add_to_database
  json(@new_assignment)
end