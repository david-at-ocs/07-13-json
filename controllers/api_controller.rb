# get "/" do
#   @assignments = Assignment.all
#   json @assignments
# end

# get "/" do
#   erb :"main/home"
# end

get "/api/assignments" do
  assignments = Assignment.all
  
  @assign_array = []  
  assignments.each do |assign|
    @assign_array << assign.make_hash
  end
  
  json @assign_array
  # json @assignments
end

get "/api/assignments/:id" do
  id = params["id"].to_i
  @assignment = Assignment.find(id)
  assignment_hash = @assignment.instance_variables.each_with_object({}) { |var, hash| hash[var.to_s.delete("@")] = @assignment.instance_variable_get(var) }
  json assignment_hash
end

get "/api/assignment_links/:id" do
  id = params["id"].to_i
  @resource = Assignment.get_resources(id)
  json(@resource)
end

get "/api/new_assignment" do
  @new_assignment_id = Assignment.add({"title" => "new_assignment", "description" => "this is a description", "github_link" => "http://www.google.com"})
  @assignment = Assignment.find(@new_assignment_id)
  assignment_hash = @assignment.instance_variables.each_with_object({}) { |var, hash| hash[var.to_s.delete("@")] = @assignment.instance_variable_get(var) }
  json assignment_hash
end


get "/api/delete_assignment_form" do
  @all_assignments = Assignment.all
  erb :"delete_assignment_form"
end

get "/api/delete_beer" do
  @beer_to_delete = Beer.find(params["beer_id"].to_i)
  Rating.delete_beer_ratings(params["beer_id"].to_i)
  if @beer_to_delete.delete
    erb :"beers/beer_deleted"
  else
    @error = true
    erb :"beers/edit_beer_form"
  end
end