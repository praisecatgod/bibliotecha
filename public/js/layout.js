function validateEmail(email) {
  var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  return re.test(email);
}

function validateLibraryCard(card) {
  return card.length==10;
}

$("#signUpButton").click(function() {
  var json = {};
  // validate inputs here
  var escape = false;
  if( !validateLibraryCard($("#libraryCardNum").val()) ){
    console.log("no card");
    $('#signUpCard').attr('class', 'has-error');
    escape = true;
  }
  if( !validateEmail($("#emailAddress").val()) ){
    console.log("no email");
    $('#signUpEmail').attr('class', 'has-error');

    escape = true;
  }
  if($("#signUpPassword").val() !== $("#signUpPasswordConfirm").val() && ($("#signUpPasswordConfirm").val()!=="")){
    console.log("no password");
    $('#signUpPassword1').attr('class', 'has-error');
    $('#signUpPassword2').attr('class', 'has-error');

    escape = true;
  }
  if(escape){
    $('#signUpError').text("Please fix errors!");
    return;
  }

  json.library_card = $("#libraryCardNum").val();
  json.email = $("#emailAddress").val();
  json.password = $("#signUpPassword").val();
  json.password_confirm = $("#signUpPasswordConfirm").val();
  $.post("/signup", json, function(data) {
    var json = jQuery.parseJSON(data);
    if (json["message"] === "yes") {
      window.location.href = "/shelf";
    } else {
      console.log("error");
    }
  });

});

$("#logInButton").click(function(){
  var json = {};
  json.email = $("#logInCredentials").val();
  json.password = $("#logInPassword").val();
  console.log("ok");
  $.post("/login",json,function(data){
    var json = jQuery.parseJSON(data);
    if(json["message"] === "yes"){
      console.log("yay");
      window.location.href = "/shelf";
    }else{
      console.log("error");
    }
  });
});

function getUrlParameter(sParam)
{
  var sPageURL = window.location.search.substring(1);
  var sURLVariables = sPageURL.split('&');
  for (var i = 0; i < sURLVariables.length; i++)
    {
      var sParameterName = sURLVariables[i].split('=');
      if (sParameterName[0] == sParam)
        {
          return sParameterName[1];
        }
      }
}
