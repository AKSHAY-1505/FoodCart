$(document).ready(function () {
  $(".assign_agent_form").on("submit", function (e) {
    e.preventDefault();
    let data = new FormData($(this)[0]);
    let url = $(this).attr("action");
    console.log("FORM SUBMITTED");
    console.log(url);

    // FOOD Create AJAX
    $.ajax({
      url: url,
      type: "POST",
      data: data,
      processData: false,
      contentType: false,
      headers: {
        // Alternatively you can skip authenticity token verification in the controller
        "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content"),
      },
      success: function (response) {
        let orderId = response.orderId;
        let agentName = response.agentName;
        // $("#agent_for_" + orderId).html(`<p>${agentName}</p>`);
        $(`#order${orderId} .status`).text("Delivery Agent Assigned");
        $(`#order${orderId} .delivery_agent`).html(`<p>${agentName}</p>`);
      },
      error: function (error) {
        console.error("Error:", error);
      },
    });
  });
});
