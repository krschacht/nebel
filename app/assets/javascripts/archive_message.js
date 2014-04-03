var ArchiveMessage = {
  archive: function(event) {
    event.preventDefault();

    if (confirm("Are you sure? This can be undone but not from the web.")) {
      var message = this.parentElement;

      AJAX.submitForm(this, function(xhr) {
        if (xhr.status == 200) {
          message.innerHTML = xhr.response;
        } else {
          alert("There was a problem archiving the message.");
        }
      })
    }
  },

  init: function() {
    var archiveForms = document.querySelectorAll(".archive-message");

    for (var i = 0; i < archiveForms.length; i++) {
      archiveForms[i].addEventListener("submit", this.archive);
    }
  }
}

document.addEventListener("page:change", ArchiveMessage.init.bind(ArchiveMessage))
