$('.book').click(function(){
  $('#bookModal').modal('show');
  var id = this.id;
  var book = $.grep(gon.books, function(e){ return e.id == id; });
  $('#bookTitle').text(book[0].title);
  $('#bookCover').html(" <img src='/covers/"+book[0].isbn+"image.jpg' alt='"+book[0].isbn+"'> ");
  $('#bookSummary').text(book[0].summary);
  $('#rentBookID').val(id);
  var rental = $.grep(gon.rentals, function(e){ return e.book_id == id; });
  if(rental.length > 0)
  {
      $('#rentButton').hide();
      $('#rentWarning').show();
  }
  else
  {
      $('#rentButton').show();
      $('#rentWarning').hide();

  }

});

$(document).ready(function() {

  $('#bookTable').DataTable();

} );




//"/covers/"+book[0].isbn+"image.jpg"
