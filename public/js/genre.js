function editGenreModal(genre_id, genre_name){
  $('#editGenreID').val(genre_id);
  $('#editGenreName').val(genre_name);
}

function deleteGenreModal(genre_id){
  $('#deleteGenreID').val(genre_id);
}


$(document).ready(function() {
  $('#genreTable').DataTable();
} );
