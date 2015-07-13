# get "/" do
#   @assignments = Assignment.all
#   json @assignments
# end

get "/" do
  @assignments = Assignment.all
  json @assignments
  binding.pry
end

get "/assignments" do
  erb :"main/assignments"
end