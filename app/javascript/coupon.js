$(document).ready(function () {
  $(".coupons").on("click", function (e) {
    element = $(e.target);
    console.log(element);
    if (element.hasClass("coupon-delete-button")) {
      id = $(element).data("coupon-id");
      form = element.parent();
      url = "/coupons/" + id;
      console.log(url);

      // Coupon Delete Ajax
      $.ajax({
        url: url,
        type: "DELETE",
        headers: {
          // Alternatively you can skip authenticity token verification in the controller
          "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content"),
        },
        success: function (response) {
          $(`#coupon_${id}`).remove();
        },
        error: function (error) {
          console.error("Error:", error);
        },
      });
    } else if (element.hasClass("form-submit-button")) {
      e.preventDefault();
      form = element.parent();
      let data = new FormData(form[0]);
      let url = form.attr("action");
      id = $(element).attr("id");

      // Coupon Update Ajax
      $.ajax({
        url: url,
        type: "PATCH",
        data: data,
        processData: false,
        contentType: false,
        success: function (response) {
          $("#coupon_" + id).replaceWith($(response));
        },
        error: function (error) {
          console.error("Error:", error);
        },
      });
    }
  });

  $(".header").on("click", function (e) {
    element = $(e.target);
    if (element.hasClass("form-submit-button")) {
      e.preventDefault();
      form = element.parent();
      url = form.attr("action");
      data = new FormData(form[0]);

      // Coupon Create AJAX
      $.ajax({
        url: url,
        type: "POST",
        data: data,
        processData: false,
        contentType: false,
        success: function (response) {
          $(".coupons").append($(response));
        },
        error: function (error) {
          console.error("Error:", error);
        },
      });
    }
  });
});
