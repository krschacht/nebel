var PrerequisiteHighlight = {
  addHighlights: function(event) {
    var topicIDs = JSON.parse(this.getAttribute("data-all-prerequisite-topic-ids"));

    for (var i = 0; i < topicIDs.length; i++) {
      var topic = document.querySelector("#topic-" + topicIDs[i]);
      if (topic) topic.classList.add("highlight");
    }
  },

  removeHighlights: function(event) {
    var topics = document.querySelectorAll(".topic");

    for (var i = 0; i < topics.length; i++) {
      topics[i].classList.remove("highlight");
    }
  },

  init: function() {
    var topics = document.querySelectorAll(".topic");

    for (var i = 0; i < topics.length; i++) {
      topics[i].addEventListener("mouseover", this.addHighlights);
      topics[i].addEventListener("mouseout", this.removeHighlights);
    }
  }
}

document.addEventListener("page:change", PrerequisiteHighlight.init.bind(PrerequisiteHighlight));
