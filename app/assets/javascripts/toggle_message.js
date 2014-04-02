ToggleMessage = {
  toggle: function(event) {
    event.preventDefault();

    var message = this.parentElement,
        request = new XMLHttpRequest();

    request.addEventListener("readystatechange", function() {
      if (request.readyState == 4) {
        if (request.status == 200) {
          message.innerHTML = request.response;
        } else {
          alert("There was a problem opening/closing the message.");
        }
      }
    })

    request.open(this.getAttribute("method"), this.getAttribute("action"));
    request.send(new FormData(this));
  },

  init: function() {
    var toggleForms = document.querySelectorAll(".toggle-message");

    for (var i = 0; i < toggleForms.length; i++) {
      toggleForms[i].addEventListener("submit", this.toggle);
    }
  }
}

document.addEventListener("page:change", ToggleMessage.init.bind(ToggleMessage));
