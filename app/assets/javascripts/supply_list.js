var SupplyList = {
  filter: function(event) {
    var checkedCheckboxes = document.querySelectorAll("input[type='checkbox']:checked"),
        materials = document.querySelectorAll(".material"),
        checkedSubjectCodes = [];

    for (var i = 0; i < checkedCheckboxes.length; i++) {
      checkedSubjectCodes.push(checkedCheckboxes[i].value);
    }

    for (var i = 0; i < materials.length; i++) {
      var material = materials[i],
          materialSubjectCode = materials[i].getAttribute("data-subject-code");

      if (checkedSubjectCodes.indexOf(materialSubjectCode) < 0) {
        material.classList.add("hidden");
      } else {
        material.classList.remove("hidden");
      }
    }
  },

  init: function() {
    var checkboxes = document.querySelectorAll("input[type='checkbox']");

    for (var i = 0; i < checkboxes.length; i++) {
      checkboxes[i].addEventListener("change", this.filter)
    }
  }
}

document.addEventListener("page:change", SupplyList.init.bind(SupplyList));
