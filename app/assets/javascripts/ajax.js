var AJAX = {
  submitForm: function(form, done) {
    var xhr = new XMLHttpRequest();

    xhr.addEventListener("readystatechange", function() {
      if (xhr.readyState == 4) done(xhr);
    });

    xhr.open(form.getAttribute("method"), form.getAttribute("action"));
    xhr.send(new FormData(form));
  }
}
