$(document).ready(function () {
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
