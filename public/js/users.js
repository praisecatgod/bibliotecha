function statsUserModal(user_id){
  var active_rentals = $.grep(gon.active_rentals, function(e){ return e.user_id == user_id; });
  var old_rentals = $.grep(gon.old_rentals, function(e){ return e.user_id == user_id; });
  $('#activeList').empty();
  $('#historyList').empty();

 $(active_rentals).each(function() {
    var book_id = this.book_id;
    var book = $.grep(gon.books, function(e){ return e.id == book_id; });
    $("#activeList").append('<li>['+book[0].title+'] '+ (new Date(this.created_at)).toDateString() +'</li>');
  });
  $(old_rentals).each(function() {
    var book_id = this.book_id;
    var book = $.grep(gon.books, function(e){ return e.id == book_id; });
    $("#historyList").append('<li>['+book[0].title+'] '+ (new Date(this.created_at)).toDateString() +'</li>');
  });

}

function editUserModal(user_id, email, library_card){
  $('#editUserID').val(user_id);
  $('#editEmailAddress').val(email);
  $('#editLibraryCardNum').val(library_card);
}

function deleteUserModal(user_id){
  $('#deleteUserID').val(user_id);
}

function togglePasswordEdit(){
  $('#editPasswordFields').fadeToggle();
}

$(document).ready(function() {
  $('#userTable').DataTable();
  $('#editPasswordFields').hide();

} );
