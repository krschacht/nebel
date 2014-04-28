var MessageForm = {
  expand: function(event) {
    var expanded = this.nextElementSibling;

    expanded.classList.remove("hidden");
    this.classList.add("hidden");

    if (this.getAttribute("placeholder").match(/reply/)) {
      expanded.querySelector("textarea").focus();
    } else {
      expanded.querySelector("input").focus();
    }
  },

  cancel: function(event) {
    event.preventDefault();

    var expanded = this.parentElement,
        trigger  = expanded.previousElementSibling;

    expanded.classList.add("hidden");
    trigger.classList.remove("hidden");
  },

  init: function() {
    var cancelButtons = document.querySelectorAll(".new-message button.cancel"),
        triggerInputs = document.querySelectorAll("input.trigger");

    for (var i = 0; i < cancelButtons.length; i++) {
      cancelButtons[i].addEventListener("click", this.cancel);
    }

    for (var i = 0; i < triggerInputs.length; i++) {
      triggerInputs[i].addEventListener("focus", this.expand)
    }
  }
}

document.addEventListener("page:change", MessageForm.init.bind(MessageForm));
