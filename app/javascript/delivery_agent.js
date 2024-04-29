$(document).ready(function () {
  $(".status_update_form").on("submit", function (e) {
    e.preventDefault();
    let url = $(this).attr("action");
    let data = new FormData($(this)[0]);

    // AJAX PUT request
    $.ajax({
      url: url,
      type: "PUT",
      data: data,
      processData: false,
      contentType: false,
      headers: {
        "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content"),
      },
      success: function (response) {
        console.log(response);
        if (response.active) {
          $(`#order_${response.order_id} .status`).text(response.status);
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
  });
});
