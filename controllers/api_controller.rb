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

# --------------------------------------------------- crud stuff ------------------------------------------------

get "/add_assignments" do
  # @new_assignment_id = Assignment.add({"title" => "new_assignment", "description" => "this is a description", "github_link" => "http://www.google.com"})
  # @assignment = Assignment.find(@new_assignment_id)
  # assignment_hash = @assignment.instance_variables.each_with_object({}) { |var, hash| hash[var.to_s.delete("@")] = @assignment.instance_variable_get(var) }
  # json assignment_hash
  erb :"add_assignment_form"
end

get "/assignment_add" do
  new_assignment_id = Assignment.add({"title" => params["title"], "description" => params["description"], "github_link" => params["github_link"]})
  if new_assignment_id
    @new_assignment = Assignment.find(id)
    @new_assignment_hash = @new_assignment.make_hash
    json @new_assignment_hash
  else
    @error = true
    erb :"add_assignments"
  end
end


get "/delete_assignment_form" do
  @all_assignments = Assignment.all
  erb :"delete_assignment_form"
end

get "/delete_assignment" do
  @assignment_to_delete = Assignment.find(params["assignment_id"].to_i)
  Resource.delete_by_assignment_id(params["assignment_id"].to_i)
  if @assignment_to_delete.delete
    "Assignment Deleted"
  else
    @error = true
    erb :"delete_assignment_form"
  end
end