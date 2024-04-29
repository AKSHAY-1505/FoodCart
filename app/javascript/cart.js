$(document).ready(function () {
  function updateCartSummary(subtotal, deliveryCharge, discount, total) {
    $("#subtotal").text(subtotal);
    $("#delivery-charge").text(deliveryCharge);
    $("#total").text(total);
  }

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

        updateCartSummary(
          response.subtotal,
          response.delivery_charge,
          response.discount,
          response.total
        );
      },
      error: function (error) {
        console.error("Error:", error);
      },
    });
  });
});
