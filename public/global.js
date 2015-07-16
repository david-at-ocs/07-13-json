
var req = new XMLHttpRequest();

req.open("get", "/api/assignments");

req.addEventListener("load", project);

req.responseType = "json";
event.preventDefault();
req.send();

var project = function(){
  var req = this;
  var assignment_list = document.getElementsByClassName("all_assignment")[0];

  for (var i = 0; i < req.response.length; i++) {

    var li = document.createElement("li");

    list = JSON.parse(req.response[i]);
    // li.innerHTML =list.id + " " + list.name
    assignment_list.appendChild(li);
    var a = link_assignment(list.id, list.name)
    li.appendChild(a);
  };
};