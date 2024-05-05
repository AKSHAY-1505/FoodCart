$(document).ready(function () {
  $(".container").on("click", function (e) {
    element = $(e.target);
    console.log(element);
    if (element.hasClass("coupon-delete-button")) {
      id = $(element).data("coupon-id");
      form = $(this).parent();
      url = "/coupons/" + id;
      console.log(url);

      // Option Create AJAX
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
    }
  });

  $("#coupon-create-form")
    .off("submit")
    .on("submit", function (e) {
      e.preventDefault();
      form = $(this);
      url = form.attr("action");
      data = new FormData(form[0]);

      // Option Create AJAX
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
    });
});
