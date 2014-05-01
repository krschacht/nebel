var CompletionCheckbox = {
  toggle: function(event) {
    var checkbox = this;

    checkbox.setAttribute("disabled", true);

    AJAX.submitForm(this.form, function(xhr) {
      checkbox.removeAttribute("disabled");
    })
  },

  init: function() {
    var completionCheckboxes = document.querySelectorAll(".completion-checkbox");

    for (var i = 0; i < completionCheckboxes.length; i++) {
      completionCheckboxes[i].addEventListener("change", this.toggle);
    }
  }
}

document.addEventListener("page:change", CompletionCheckbox.init.bind(CompletionCheckbox));
