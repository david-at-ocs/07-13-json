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
  erb :"add_assignment_form"
end

get "/assignment_add" do
  new_assignment_id = Assignment.add({"title" => params["title"], "description" => params["description"], "github_link" => params["github_link"]})
  if new_assignment_id
    @new_assignment = Assignment.find(new_assignment_id)
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

get "/add_resource" do
  @all_assignments = Assignment.all
  erb :"add_resource_form"
end

get "/resource_added" do
  new_resource_id = Resource.add({"title" => params["title"], "resource_link" => params["resource_link"], "type" => params["type"], "assignment_id" => params["assignment_id"]})
  if new_resource_id
    @new_resource = Resource.find(new_resource_id)
    @new_resource_hash = @new_resource.make_hash
    json @new_resource_hash
  else
    @error = true
    erb :"add_assignments"
  end
end

get "/add_collaborator" do
  @all_assignments = Assignment.all
  erb :"add_collaborator_form"
end

get "/collaborator_added" do
  new_collab_id = Collaborator.add({"name" => params["name"], "assignment_id" => params["assignment_id"]})
  if new_collab_id
    @new_collab = Collaborator.find(new_collab_id)
    @new_collab_hash = @new_collab.make_hash
    json @new_collab_hash
  else
    @error = true
    @all_assignments = Assignment.all
    erb :"add_collaborator_form"
  end
end






  