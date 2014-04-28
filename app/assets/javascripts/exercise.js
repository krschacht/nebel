var Exercise = {
  collapse: function(event) {
    var anchorHash = this.getAttribute("href").match(/#.*/)[0];

    if (window.location.hash == anchorHash) {
      window.location.hash = "";
      event.preventDefault();
    }
  },

  init: function() {
    var anchors = document.querySelectorAll(".exercise header a");

    for (var i = 0; i < anchors.length; i++) {
      anchors[i].addEventListener("click", this.collapse);
    }
  }
};

document.addEventListener("page:change", Exercise.init.bind(Exercise));
