$(document).ready(function () {
  $(".cartContainer").on("click", function (e) {
    let element = $(e.target);

    if (element.hasClass("remove-coupon")) {
      e.preventDefault();

      //Remove Coupon Ajax
      $.ajax({
        url: "/removeCoupon",
        type: "POST",
        headers: {
          // Alternatively you can skip authenticity token verification in the controller
          "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content"),
        },
        processData: false,
        contentType: false,
        success: function (response) {
          $("#cart-summary").replaceWith($(response));
        },
        error: function (error) {
          console.error("Error:", error);
        },
      });
    } else if (element.hasClass("apply-coupon-button")) {
      e.preventDefault();
      let form = element.parent().parent();
      console.log(form);

      let data = new FormData(form[0]);

      // Apply Coupon Ajax
      $.ajax({
        url: "/applyCoupon",
        type: "POST",
        data: data,
        processData: false,
        contentType: false,
        success: function (response) {
          console.log(response);
          $("#cart-summary").replaceWith($(response));
        },
        error: function (error) {
          console.error("Error:", error);
        },
      });
    }
  });

  $(".remove-button").on("click", function (event) {
    let cartItemId = $(this).data("cart-item-id");
    let currentButton = $(this);

    $.ajax({
      url: "/cart_items/" + cartItemId,
      type: "DELETE",
      headers: {
        // Alternatively you can skip authenticity token verification in the controller
        "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content"),
      },
      success: function (response) {
        console.log(response);
        let parentDiv = currentButton.closest(".row.cart-row");
        parentDiv.remove();
        $("#cart-summary").replaceWith($(response));
      },
      error: function (error) {
        console.error("Error:", error);
      },
    });
  });
});
