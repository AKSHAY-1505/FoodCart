
$(document).ready(function () {

    function updateCartSummary(subtotal) {
        $('#subtotal').text(subtotal);
        let deliveryCharge = subtotal > 500 ? 0 : 30;
        $('#delivery-charge').text(deliveryCharge);
        $('#total').text(subtotal + deliveryCharge);
    }
  
    $('.remove-button').on('click', function(event) {
      
      let cartItemId = $(this).data('cart-item-id');
      let currentButton = $(this);
  
      $.ajax({
        url: '/cart_items/'+cartItemId,
        type: 'DELETE',
        headers: { // Alternatively you can skip authenticity token verification in the controller
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') 
        },
        success: function(response) {
          console.log(response);
          let parentDiv = currentButton.closest('.row.cart-row');
          parentDiv.remove();
          subtotal = response.total;

          updateCartSummary(subtotal);

        },
        error: function(error) {
          console.error('Error:', error);
        }
      });
    });
    
  });
  
  
  
  