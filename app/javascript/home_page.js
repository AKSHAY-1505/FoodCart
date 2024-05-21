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

  function showDangerToast(message) {
    $("#danger-toast-message .toast-body").text(message);
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
      if (currentValue > 0) {
        $quantityInput.val(currentValue - 1);
      }
    });

  $(".add_to_cart_form")
    .off("submit")
    .on("submit", function (event) {
      event.preventDefault();

      let quantity = $(this).find("#quantity").val();
      let foodId = $(this).find("#quantity").data("food-id");
      let form = $(this);
      let data = {
        order_item: {
          quantity: quantity,
          food_id: foodId,
        },
      };
      if (quantity > 0) {
        $.ajax({
          url: "/order_items",
          type: "POST",
          data: data,
          headers: {
            "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content"),
          },
          success: function (response) {
            console.log(response);
            form.find("#quantity").val(0);
            showSuccessToast();
            button = form.find(".increment");
            previousQuantity = button.data("quantity");
            newQuantity = previousQuantity - quantity;
            button.data("quantity", newQuantity);
            $("#cart-count").text(response.cart_count);
          },
          error: function (error) {
            showDangerToast("Please Login to add to cart!");
          },
        });
      } else {
        showDangerToast("Quantity Must be Greater than 0 !");
      }
    });

  $("#search-form").on("submit", function (event) {
    event.preventDefault();
    let data = {
      name: $("#search_name").val(),
    };
    console.log(data);

    // Search Food Ajax
    $.ajax({
      url: "/search",
      type: "GET",
      data: data,
      headers: {
        // Alternatively you can skip authenticity token verification in the controller
        "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content"),
      },
      success: function (response) {
        $("#results").replaceWith($(response));
      },
      error: function (error) {
        showDangerToast("No Matches Found!");
      },
    });
  });
});
