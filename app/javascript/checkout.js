$(document).ready(function () {
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
          name: "order[address_id]",
          value: newAddress.id,
          id: "address_" + newAddress.id,
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
