$(document).ready(function () {
  $("#promotions").on("click", function (e) {
    element = $(e.target);

    if (element.hasClass("promotion-submit-button")) {
      e.preventDefault();
      let id = element.data("promotionId");
      let form = element.parent();
      let data = new FormData(form[0]);
      let url = form.attr("action");

      // Promotion Update AJAX
      $.ajax({
        url: url,
        type: "PATCH",
        data: data,
        processData: false,
        contentType: false,
        success: function (response) {
          $("#promotion_" + id).replaceWith($(response));
        },
        error: function (error) {
          console.error("Error:", error);
        },
      });
    } else if (element.hasClass("promotion-delete-button")) {
      e.preventDefault();
      form = element.parent();
      let url = form.attr("action");
      // Promotion Delete AJAX
      $.ajax({
        url: url,
        type: "DELETE",
        headers: {
          // Alternatively you can skip authenticity token verification in the controller
          "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content"),
        },
        success: function (response) {
          $("#promotion_" + response.promotionId).remove();
        },
        error: function (error) {
          console.error("Error:", error);
        },
      });
    }
  });

  $(".header").on("click", function (e) {
    element = $(e.target);
    if (element.hasClass("promotion-submit-button")) {
      e.preventDefault();
      form = element.parent();
      url = form.attr("action");
      data = new FormData(form[0]);

      // Promotion Create AJAX
      $.ajax({
        url: url,
        type: "POST",
        data: data,
        processData: false,
        contentType: false,
        success: function (response) {
          let parentDiv = $("#promotions");
          parentDiv.append($(response));
          form[0].reset();
        },
        error: function (error) {
          console.error("Error:", error);
        },
      });
    }
  });
});
