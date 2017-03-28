function editAuthorModal(author_id, author_name){
  $('#editAuthorID').val(author_id);
  $('#editAuthorName').val(author_name);
}

function deleteAuthorModal(author_id){
  $('#deleteAuthorID').val(author_id);
}

$(document).ready(function() {
  $('#authorTable').DataTable();
} );
