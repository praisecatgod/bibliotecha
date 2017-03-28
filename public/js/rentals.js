function returnBook(rental_id){
  var json = {};
  json.rental_id = rental_id;
  $.post("/return",json,function(data){
    location.reload();
  });

}

$(document).ready(function() {
  $('#activeRentals').DataTable();
  $('#expiredRentals').DataTable();
  $('#rentalHistory').DataTable();
} );