var SupplyList = {
  filter: function(event) {
    var checkedCheckboxes = document.querySelectorAll("input[type='checkbox']:checked"),
        materials = document.querySelectorAll(".material"),
        checkedSubjectCodes = [];

    for (var i = 0; i < checkedCheckboxes.length; i++) {
      checkedSubjectCodes.push(checkedCheckboxes[i].value);
    }

    for (var i = 0; i < materials.length; i++) {
      var materialElem = materials[i];
      var quantityElem = materialElem.querySelector(".quantity")
      var singularNameElem = materialElem.querySelector(".singular")
      var pluralNameElem = materialElem.querySelector(".plural")

      materialElem.classList.add("hidden");
      if(quantityElem != null) {
        quantityElem.innerHTML = 0;
        pluralNameElem.classList.add("hidden");
        singularNameElem.classList.remove("hidden");
      }

      for(var j = 0; j < checkedSubjectCodes.length; j++) {
        if(materialElem.getAttribute("data-subject-code-" + checkedSubjectCodes[j]) != null) {
          materialElem.classList.remove("hidden");
          dataQuantity = materialElem.getAttribute("data-quantity-" + checkedSubjectCodes[j]);

          if(quantityElem != null && dataQuantity != null) {
            var qty = Math.max( parseInt(quantityElem.innerHTML), parseInt(dataQuantity) );
            if( isNaN(qty) ) {
              quantityElem.innerHTML = '';
            } else {
              quantityElem.innerHTML = qty;
            }
            if(qty > 1) {
              pluralNameElem.classList.remove("hidden");              
              singularNameElem.classList.add("hidden");
            } else {
              pluralNameElem.classList.add("hidden");              
              singularNameElem.classList.remove("hidden");              
            }
          }
        }
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
