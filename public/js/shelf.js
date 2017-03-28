function downloadBook(isbn){
  var json = {};
  json.isbn = isbn;
  $.post("/download",json,function(data){
    var book = $.grep(gon.books, function(e){ return e.isbn == isbn; });
    var textToWrite = data;
    var textFileAsBlob = new Blob([textToWrite], {type:'text/plain'});
    var fileNameToSaveAs = book[0].title;
    var downloadLink = document.createElement("a");
    downloadLink.download = fileNameToSaveAs;
    downloadLink.innerHTML = "Download File";
    if (window.webkitURL != null)
    {
      downloadLink.href = window.webkitURL.createObjectURL(textFileAsBlob);
    }
    else
    {
      downloadLink.href = window.URL.createObjectURL(textFileAsBlob);
      downloadLink.onclick = destroyClickedElement;
      downloadLink.style.display = "none";
      document.body.appendChild(downloadLink);
    }

    downloadLink.click();
  });
}

function returnBook(rental_id){
  var json = {};
  json.rental_id = rental_id;
  $.post("/return",json,function(data){
    location.reload();
  });

}

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
