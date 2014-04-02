var MessageForm = {
  show: function(event) {
    var form = this.nextElementSibling,
        subject = form["message[subject]"];

    this.classList.add("hidden");
    form.classList.remove("hidden");

    if (getComputedStyle(subject).display == "none") {
      form["message[body]"].focus();
    } else {
      subject.focus();
    }
  },

  cancel: function(event) {
    event.preventDefault();

    var form = this.parentElement;
    form.classList.add("hidden");
    form.previousElementSibling.classList.remove("hidden");
  },

  init: function() {
    var replyButtons  = document.querySelectorAll(".message button.reply"),
        cancelButtons = document.querySelectorAll(".new-message button.cancel"),
        newButton     = document.querySelector("button#new-message");

    for (var i = 0; i < replyButtons.length; i++) {
      replyButtons[i].addEventListener("click", this.show);
    }

    for (var i = 0; i < cancelButtons.length; i++) {
      cancelButtons[i].addEventListener("click", this.cancel);
    }

    if (newButton) newButton.addEventListener("click", this.show);
  }
}

document.addEventListener("page:change", MessageForm.init.bind(MessageForm));
