function statsBookModal(book_id){
  var active_rentals = $.grep(gon.active_rentals, function(e){ return e.book_id == book_id; });
  var old_rentals = $.grep(gon.old_rentals, function(e){ return e.book_id == book_id; });
  var book_author = $.grep(gon.book_author, function(e){ return e.book_id == book_id; });
  var book_genre = $.grep(gon.book_genre, function(e){ return e.book_id == book_id; });

  $('#activeList').empty();
  $('#historyList').empty();
  $('#authorList').empty();
  $('#genreList').empty();

  $(active_rentals).each(function() {
    var user_id = this.user_id;
    var user = $.grep(gon.users, function(e){ return e.id == user_id; });
    $("#activeList").append('<li>['+user[0].library_card+'] '+ (new Date(this.created_at)).toDateString() +'</li>');
  });
  $(old_rentals).each(function() {
    var user_id = this.user_id;
    var user = $.grep(gon.users, function(e){ return e.id == user_id; });
    $("#historyList").append('<li>['+user[0].library_card+'] '+ (new Date(this.created_at)).toDateString() +'</li>');
  });

  $(book_author).each(function() {
    var author_id = this.author_id;
    var author = $.grep(gon.authors, function(e){ return e.id == author_id; });
    $("#authorList").append('<li>'+ author[0].author_name +'</li>');
  });
  $(book_genre).each(function() {
    var genre_id = this.genre_id;
    var genre = $.grep(gon.genres, function(e){ return e.id == genre_id; });
    $("#genreList").append('<li>'+ genre[0].genre_name +'</li>');
  });

}

function editBooksModal(book_id){
  var book = $.grep(gon.books, function(e){ return e.id == book_id; });
  var book_author = $.grep(gon.book_author, function(e){ return e.book_id == book_id; });
  var book_genre = $.grep(gon.book_genre, function(e){ return e.book_id == book_id; });

  $('#editBookID').val(book[0].id);
  $('#editBookISBN').val(book[0].isbn);
  $('#editBookTitle').val(book[0].title);
  $('#editBookSummary').val(book[0].summary);

  console.log( $('#editBookID').val() );
  $('#editBookGenre').select2("val", ""); 
  $('#editBookAuthor').select2("val", ""); 

  var authors = [];
  $(book_author).each(function() {
    var author_id = this.author_id;
    var author = $.grep(gon.authors, function(e){ return e.id == author_id; });
    var obj = new Object();
    obj.id = author[0].id;
    obj.text  = author[0].author_name;
    authors.push( obj );
  });
  
  $("#editBookAuthor").select2("data", authors );
  var genres = [];
  $(book_genre).each(function() {
    var genre_id = this.genre_id;
    var genre = $.grep(gon.genres, function(e){ return e.id == genre_id; });
    var obj = new Object();
    obj.id = genre[0].id;
    obj.text  = genre[0].genre_name;
    genres.push( obj );
  });
  $("#editBookGenre").select2("data", genres );

}

function deleteBookModal(book_id){
  $('#deleteBookID').val(book_id);
}

$(document).ready(function() {
  $('#bookTable').DataTable({"autoWidth": false});

  $("#addBookAuthor").select2({
    placeholder: "Authors",
    allowClear: true
  });

  $("#addBookGenre").select2({
    placeholder: "Genres",
    allowClear: true
  });

  $("#editBookGenre").select2({
    placeholder: "Genres",
    allowClear: true
  });

  $("#editBookAuthor").select2({
    placeholder: "Authors",
    allowClear: true
  });
} );
