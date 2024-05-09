$(document).ready(function () {
  $("#apply-coupon-button").on("click", function (e) {
    e.preventDefault();
    let code = $("#coupon_code").val();
    let data = {
      code: code,
    };

    // Apply Coupon Ajax
    $.ajax({
      url: "/applyCoupon",
      type: "POST",
      data: data,
      headers: {
        // Alternatively you can skip authenticity token verification in the controller
        "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content"),
      },
      success: function (response) {
        let messageContainer = $("#coupon-response");
        let successMessage = $("<p>").text("Coupon Applied Successfully");

        successMessage.attr("id", "coupon-response");
        successMessage.css({
          color: "green",
        });

        messageContainer.replaceWith(successMessage);
        $("#cart-summary").replaceWith($(response));

        $("#coupon-code-field").val(code);
      },
      error: function (error) {
        let messageContainer = $("#coupon-response");
        let failureMessage = $("<p>").text(
          "Invalid Coupon / Minimum Requirement Not Met"
        );

        failureMessage.attr("id", "coupon-response");
        failureMessage.css({
          color: "red",
        });

        messageContainer.replaceWith(failureMessage);
        $("#cart-summary").replaceWith($(error.responseText));

        $("#coupon-code-field").val("");
      },
    });
  });

  $("#new-address-form").on("submit", function (e) {
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
        var newAddress = response.address;

        var addressField = $("<div>").addClass("address field");
        var radioButton = $("<input>").attr({
          type: "radio",
          name: "address_id",
          value: newAddress.id,
          id: "address_" + newAddress.id,
          class: "hidden-radio",
        });
        var label = $("<label>")
          .attr("for", "address_" + newAddress.id)
          .text(
            newAddress.house_number +
              "," +
              newAddress.street_name +
              "," +
              newAddress.locality +
              "," +
              newAddress.city
          );

        addressField.append(radioButton).append(label);

        $(".addresses").append(addressField);
      },
      error: function (error) {
        console.error("Error:", error);
      },
    });
  });
});
