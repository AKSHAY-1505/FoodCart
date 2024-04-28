$(document).ready(function () {
  $("#categories").on("click", function (e) {
    element = $(e.target);

    if (element.hasClass("food-delete-button")) {
      let id = element.data("food-id");

      // Food Delete AJAX
      $.ajax({
        url: "/foods/" + id,
        type: "DELETE",
        headers: {
          // Alternatively you can skip authenticity token verification in the controller
          "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content"),
        },
        success: function (response) {
          $("#food_" + id).remove();
        },
        error: function (error) {
          console.error("Error:", error);
        },
      });
    } else if (element.hasClass("food-update-button")) {
      e.preventDefault();
      let form = element.parent();
      let data = new FormData(form[0]);
      let id = element.data("food-id");

      // Food Update AJAX
      $.ajax({
        url: "/foods/" + id,
        type: "PUT",
        data: data,
        processData: false,
        contentType: false,
        headers: {
          // Alternatively you can skip authenticity token verification in the controller
          "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content"),
        },
        success: function (response) {
          $("#food_" + id).replaceWith($(response));
        },
        error: function (error) {
          console.error("Error:", error);
        },
      });
    }
  });

  $("#food_create_form").on("submit", function (e) {
    e.preventDefault();
    data = new FormData($(this)[0]);

    // FOOD Create AJAX
    $.ajax({
      url: "/foods",
      type: "POST",
      data: data,
      processData: false,
      contentType: false,
      headers: {
        // Alternatively you can skip authenticity token verification in the controller
        "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content"),
      },
      success: function (response) {
        let parentDiv = $("#newly_created");
        parentDiv.append($(response));
      },
      error: function (error) {
        console.error("Error:", error);
      },
    });
  });
});