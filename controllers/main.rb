# get "/" do
#   @assignments = Assignment.all
#   json @assignments
# end


get "/assignments" do
  erb :"main/assignments"
end

get "/" do
  erb :"/home"
end