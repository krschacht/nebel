var ToggleMessage = {
  toggle: function(event) {
    event.preventDefault();

    var message = this.parentElement;

    AJAX.submitForm(this, function(xhr) {
      if (request.status == 200) {
        message.innerHTML = request.response;
      } else {
        alert("There was a problem opening/closing the message.");
      }
    });
  },

  init: function() {
    var toggleForms = document.querySelectorAll(".toggle-message");

    for (var i = 0; i < toggleForms.length; i++) {
      toggleForms[i].addEventListener("submit", this.toggle);
    }
  }
}

document.addEventListener("page:change", ToggleMessage.init.bind(ToggleMessage));
