var AJAX = {
  showLoader: function() {
    var loader = document.querySelector("#loader");
    if (loader) loader.classList.remove("hidden");
  },

  hideLoader: function() {
    var loader = document.querySelector("#loader");
    if (loader) loader.classList.add("hidden");
  },

  submitForm: function(form, done) {
    var xhr = new XMLHttpRequest();

    xhr.addEventListener("readystatechange", function() {
      if (xhr.readyState == 4) {
        this.hideLoader();
        done(xhr);
      }
    }.bind(this));

    xhr.open(form.getAttribute("method"), form.getAttribute("action"));
    xhr.send(new FormData(form));
    this.showLoader();
  }
}

document.addEventListener("page:before-change", AJAX.showLoader.bind(AJAX));
document.addEventListener("page:change", AJAX.hideLoader.bind(AJAX));
