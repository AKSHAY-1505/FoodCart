$(document).ready(function () {
  // Code to gray out and disable out-of-stock food items
  const outOfStockWarnings = $(".out_of_stock_warning");

  outOfStockWarnings.each(function () {
    const foodItem = $(this).closest(".food_item");
    foodItem.css("opacity", "0.5");

    foodItem.find("img").css("filter", "grayscale(100%)");

    foodItem
      .find("a")
      .addClass("disabled")
      .on("click", function (e) {
        e.preventDefault();
      });
  });

  function showSuccessToast() {
    var toastElement = document.getElementById("success-toast-message");
    var toast = new bootstrap.Toast(toastElement);
    toast.show();
  }

  function showDangerToast() {
    var toastElement = document.getElementById("danger-toast-message");
    var toast = new bootstrap.Toast(toastElement);
    toast.show();
  }

  function displayWarning(button, quantity) {
    let warningContainer = button.closest(".container").find(".warning");
    let warning = $("<p>").text(`Only ${quantity} left in Stock.`);
    warningContainer.html(warning);
  }
  // Unbind existing event handlers to prevent multiple bindings
  $(".increment")
    .off("click")
    .on("click", function () {
      let quantity = $(this).data("quantity");
      let $quantityInput = $(this).siblings(".quantity");
      let currentValue = parseInt($quantityInput.val());
      if (isNaN(currentValue)) {
        currentValue = 0;
      }
      if (currentValue < quantity) $quantityInput.val(currentValue + 1);
      else displayWarning($(this), quantity);
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
        order_item: {
          quantity: quantity,
          food_id: foodId,
        },
      };

      $.ajax({
        url: "/order_items",
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
