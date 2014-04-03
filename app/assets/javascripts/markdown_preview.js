var MarkdownPreview = {
  loadPreview: function(event) {
    event.preventDefault();

    var form = document.createElement("form"),
        textarea = document.createElement("textarea");

    form.setAttribute("action", "/markdown/preview");
    form.setAttribute("method", "POST");
    form.setAttribute("target", "_blank");
    textarea.setAttribute("name", "string");
    textarea.textContent = this.nextElementSibling.value;

    form.appendChild(textarea);

    form.submit();
  },

  createContainer: function() {
    var div = document.createElement("div");
    div.classList.add("markdown-preview-container");
    return div;
  },

  createButton: function() {
    var button = document.createElement("button");
    button.textContent = "Preview";
    button.addEventListener("click", this.loadPreview);
    return button;
  },

  init: function() {
    var textareas = document.querySelectorAll("textarea");

    for (var i = 0; i < textareas.length; i++) {
      var textarea = textareas[i],
          button   = this.createButton(),
          div      = this.createContainer();

      textarea.parentNode.insertBefore(div, textarea);

      div.appendChild(button);
      div.appendChild(textarea);
    }
  }
}

document.addEventListener("page:change", MarkdownPreview.init.bind(MarkdownPreview));
