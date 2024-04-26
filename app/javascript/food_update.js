$(document).ready(function () {  
  
    $('.food-update-form').on('submit', function(event) {
      event.preventDefault(); 
      
      let data = new FormData(this);
      let id = $(this).data('food-id');

      $.ajax({
        url: '/foods/' + id,
        type: 'PUT',
        data: data,
        processData: false,
        contentType: false, 
        headers: { // Alternatively you can skip authenticity token verification in the controller
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') 
        },
        success: function(response) {
          $('#food_'+id).replaceWith($(response))
        },
        error: function(error) {
          console.error('Error:', error);
        }
      });
    });


});
