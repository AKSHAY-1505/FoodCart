$(document).ready(function () {
  function showSuccessToast() {
    var toastElement = document.getElementById("addToCartToast");
    var toast = new bootstrap.Toast(toastElement);
    toast.show();
  }

  function showDangerToast() {
    var toastElement = document.getElementById("pleaseLoginToast");
    var toast = new bootstrap.Toast(toastElement);
    toast.show();
  }
  // Unbind existing event handlers to prevent multiple bindings
  $(".increment")
    .off("click")
    .on("click", function () {
      let $quantityInput = $(this).siblings(".quantity");
      let currentValue = parseInt($quantityInput.val());
      if (isNaN(currentValue)) {
        currentValue = 0;
      }
      $quantityInput.val(currentValue + 1);
    });

  $(".decrement")
    .off("click")
    .on("click", function () {
      let $quantityInput = $(this).siblings(".quantity");
      let currentValue = parseInt($quantityInput.val());
      if (isNaN(currentValue)) {
        currentValue = 0;
      }
      if (currentValue > 1) {
        $quantityInput.val(currentValue - 1);
      }
    });

  $(".add_to_cart_form")
    .off("submit")
    .on("submit", function (event) {
      event.preventDefault();

      let quantity = $(this).find("#quantity").val();
      let foodId = $(this).find("#quantity").data("food-id");

      let data = {
        quantity: quantity,
        food_id: foodId,
      };

      $.ajax({
        url: "/cart_items",
        type: "POST",
        data: data,
        headers: {
          "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content"),
        },
        success: function (response) {
          console.log(response);
          $(this).find("#quantity").val(1);
          showSuccessToast();
        },
        error: function (error) {
          showDangerToast();
        },
      });
    });
});
