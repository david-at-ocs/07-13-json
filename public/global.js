if (document.body.attributes.data_page_name.value === "home page") {
  function seeAllAssignments(event) {
    event.preventDefault();
    
    var req = new XMLHttpRequest();
    req.open("get", "/api/assignments");
    
    req.addEventListener("load", function(){
      document.getElementById("assignments").innerText = "";
      for(var i = 0; i < this.response.length; i++) {
        var assignment = this.response[i]
        var newDivId = "assignment" + assignment.id;
        var newDiv = document.createElement("li");
        newDiv.id = newDivId
        newDiv.dataId = assignment.id
        newDiv.innerText = assignment.assignment_name;
        var currentDiv = document.getElementById("assignments");
        currentDiv.appendChild(newDiv);
        document.getElementById(newDivId).onclick = showAssignment;
        
        
        // document.body.insertBefore(newDiv, currentDiv.lastChild);
      }
    });
    req.responseType = "json";
    req.send();
  }
}