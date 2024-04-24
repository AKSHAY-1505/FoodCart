$(document).ready(function () {
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
});
