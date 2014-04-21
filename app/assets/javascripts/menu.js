var Menu = {
  close: function(event) {
    var menu = document.querySelector(".menu"),
        content = menu.querySelector(".content");

    if (!menu.contains(event.target) && !content.classList.contains("hidden")) {
      content.classList.add("hidden");
    }
  },

  activate: function(event) {
    event.preventDefault();
    var content = document.querySelector(".menu .content");
    content.classList.toggle("hidden");
  },

  init: function() {
    var body = document.querySelector("body"),
        activator = document.querySelector(".menu .activator");

    activator.addEventListener("click", this.activate);
    body.addEventListener("click", this.close);
  }
}

document.addEventListener("page:change", Menu.init.bind(Menu));
