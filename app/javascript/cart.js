$(document).ready(function () {
  // Unbind existing event handlers to prevent multiple bindings
  $(".cart-items")
    .off("click")
    .on("click", function (e) {
      let element = $(e.target);
      console.log(element);
      if (element.hasClass("increment")) {
        let quantity = $(element).data("quantity");
        let quantityInput = $(element).siblings(".quantity");
        let currentValue = parseInt(quantityInput.val());
        let entryId = quantityInput.data("entry-id");
        if (isNaN(currentValue)) {
          console.log("HERE");
          currentValue = 0;
        }
        if (currentValue < quantity) {
          quantityInput.val(currentValue + 1);
          $.ajax({
            url: `/order_items/${entryId}`,
            type: "PATCH",
            headers: {
              // Alternatively you can skip authenticity token verification in the controller
              "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content"),
            },
            data: {
              order_item: {
                id: entryId,
                quantity: currentValue + 1,
              },
            },
            success: function (response) {
              $("#cart-summary").replaceWith($(response.cart_summary_html));
              $(`#cart_entry_${entryId}`).replaceWith(
                $(response.cart_entry_html)
              );
            },
            error: function (error) {
              console.error("Error:", error);
            },
          });
        }
      } else if (element.hasClass("decrement")) {
        let quantityInput = $(element).siblings(".quantity");
        let currentValue = parseInt(quantityInput.val());
        let entryId = quantityInput.data("entry-id");

        if (isNaN(currentValue)) {
          currentValue = 0;
        }
        if (currentValue > 1) {
          quantityInput.val(currentValue - 1);
          $.ajax({
            url: `/order_items/${entryId}`,
            type: "PATCH",
            headers: {
              // Alternatively you can skip authenticity token verification in the controller
              "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content"),
            },
            data: {
              order_item: {
                id: entryId,
                quantity: currentValue - 1,
              },
            },
            success: function (response) {
              $("#cart-summary").replaceWith($(response.cart_summary_html));
              $(`#cart_entry_${entryId}`).replaceWith(
                $(response.cart_entry_html)
              );
            },
            error: function (error) {
              console.error("Error:", error);
            },
          });
        }
      } else if (element.hasClass("remove-button")) {
        let orderItemId = $(element).data("order-item-id");
        let currentButton = $(element);

        $.ajax({
          url: "/order_items/" + orderItemId,
          type: "DELETE",
          headers: {
            // Alternatively you can skip authenticity token verification in the controller
            "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content"),
          },
          success: function (response) {
            console.log(response);
            let parentDiv = currentButton.closest(".row.cart-row");
            parentDiv.remove();
            $("#cart-count").text(response.cart_count);
            $("#cart-summary").replaceWith(response.cart_summary_html);
          },
          error: function (error) {
            console.error("Error:", error);
          },
        });
      }
    });

  // $(".cartContainer").on("click", function (e) {
  //   let element = $(e.target);

  //   if (element.hasClass("remove-coupon")) {
  //     e.preventDefault();

  //     //Remove Coupon Ajax
  //     $.ajax({
  //       url: "/removeCoupon",
  //       type: "POST",
  //       headers: {
  //         // Alternatively you can skip authenticity token verification in the controller
  //         "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content"),
  //       },
  //       processData: false,
  //       contentType: false,
  //       success: function (response) {
  //         $("#cart-summary").replaceWith($(response));
  //       },
  //       error: function (error) {
  //         console.error("Error:", error);
  //       },
  //     });
  //   } else if (element.hasClass("apply-coupon-button")) {
  //     e.preventDefault();
  //     let form = element.parent().parent();
  //     console.log(form);

  //     let data = new FormData(form[0]);

  //     // Apply Coupon Ajax
  //     $.ajax({
  //       url: "/applyCoupon",
  //       type: "POST",
  //       data: data,
  //       processData: false,
  //       contentType: false,
  //       success: function (response) {
  //         console.log(response);
  //         $("#cart-summary").replaceWith($(response));
  //       },
  //       error: function (error) {
  //         console.error("Error:", error);
  //       },
  //     });
  //   }
  // });

  // $(".remove-button")
  //   .off("click")
  //   .on("click", function (event) {});
});
