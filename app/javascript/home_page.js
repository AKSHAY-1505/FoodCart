
$(document).ready(function () {

  function showToast() {
    var toastElement = document.getElementById('addToCartToast');
    var toast = new bootstrap.Toast(toastElement);
    toast.show();
  }

  $(".increment").on("click", function () {
    let $quantityInput = $(this).siblings(".quantity");
    let currentValue = parseInt($quantityInput.val());
    if (isNaN(currentValue)) {
      currentValue = 0;
    }
    $quantityInput.val(currentValue + 1);
  });

  $(".decrement").on("click", function () {
    let $quantityInput = $(this).siblings(".quantity");
    let currentValue = parseInt($quantityInput.val());
    if (isNaN(currentValue)) {
      currentValue = 0;
    }
    if (currentValue > 1) {
      $quantityInput.val(currentValue - 1);
    }
  });

  $('.add_to_cart_form').on('submit', function(event) {
    event.preventDefault(); 
    
    let quantity = $(this).find('#quantity').val();
    let foodId = $(this).find('#quantity').data('food-id');

    let data = {
      quantity: quantity,
      food_id: foodId,
    }

    $.ajax({
      url: '/addToCart',
      type: 'POST',
      data: data,
      headers: { // Alternatively you can skip authenticity token verification in the controller
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') 
      },
      success: function(response) {
        // console.log(response);
        $(this).find('#quantity').val(1);
        showToast()
      },
      error: function(xhr, status, error) {
        console.error('Error:', error);
      }
    });
  });
});



