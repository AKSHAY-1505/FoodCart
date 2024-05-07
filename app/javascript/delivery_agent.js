$(document).ready(function () {
  $(".pending-orders").on("click", function (e) {
    element = $(e.target);

    if (element.hasClass("out-for-delivery")) {
      let orderId = element.data("order-id");
      let data = {
        status: element.data("status"),
      };
      console.log(data);
      $.ajax({
        url: `/orders/${orderId}`,
        type: "PUT",
        data: data,
        headers: {
          "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content"),
        },
        success: function (response) {
          console.log(response);
          if (response.active) {
            $(`#order_${response.order_id} .status`).text(response.status);
            let newButton = $("<button>", {
              text: "Mark as Delivered",
              class: "btn btn-success delivered",
              "data-order-id": response.order_id,
              "data-status": "delivered",
            });
            element.replaceWith(newButton);
            console.log("Updated");
          } else {
            $(`#order_${response.order_id}`).remove();
            console.log("Removed");
          }
        },
        error: function (error) {
          console.error("Error:", error);
        },
      });
    } else if (element.hasClass("delivered")) {
      let orderId = element.data("order-id");
      let data = {
        status: element.data("status"),
      };
      $.ajax({
        url: `/orders/${orderId}`,
        type: "PUT",
        data: data,
        headers: {
          "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content"),
        },
        success: function (response) {
          console.log(response);
          if (response.active) {
            $(`#order_${response.order_id} .status`).text(response.status);
          } else {
            $(`#order_${response.order_id}`).remove();
            console.log("Removed");
          }
        },
        error: function (error) {
          console.error("Error:", error);
        },
      });
    }
  });
});
