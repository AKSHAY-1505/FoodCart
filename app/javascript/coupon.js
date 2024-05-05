$(document).ready(function () {
  $("#coupon-create-form").on("submit", function (e) {
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

  $(".coupon-delete-button").on("click", function (e) {
    element = $(e.target);
    if (element.hasClass("coupon-delete-button")) {
      id = $(this).data("coupon-id");
      form = $(this).parent();
      url = "/coupons/" + id;
      console.log(url);

      // Option Create AJAX
      $.ajax({
        url: url,
        type: "DELETE",
        success: function (response) {
          $(`#coupon_${id}`).remove();
        },
        error: function (error) {
          console.error("Error:", error);
        },
      });
    }
  });
});
