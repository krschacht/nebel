var MarkdownPreview = {
  loadPreview: function(event) {
    event.preventDefault();

    var form = document.createElement("form"),
        textarea = document.createElement("textarea");

    form.setAttribute("action", "/markdown/preview");
    form.setAttribute("method", "POST");
    form.setAttribute("target", "_blank");
    textarea.setAttribute("name", "string");
    textarea.textContent = this.previousElementSibling.querySelector("textarea").value;

    form.appendChild(textarea);

    form.submit();
  },

  createButton: function() {
    var button = document.createElement("button");
    button.textContent = "Preview";
    button.setAttribute("title", "Preview this message in a new tab")
    button.addEventListener("click", this.loadPreview);
    return button;
  },

  init: function() {
    var textareas = document.querySelectorAll("textarea");

    for (var i = 0; i < textareas.length; i++) {
      var textarea = textareas[i],
          button   = this.createButton();

      //textarea.parentElement.insertAdjacentElement("afterend", button)
    }
  }
}

document.addEventListener("page:change", MarkdownPreview.init.bind(MarkdownPreview));
