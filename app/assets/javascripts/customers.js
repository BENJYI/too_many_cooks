window.onload = function(){
  // Create a Stripe client
  var stripe = Stripe('pk_test_I6RYjLajDfrdoE3eGdGA19Tj');

  // Create an instance of Elements
  var elements = stripe.elements();

  // Custom styling can be passed to options when creating an Element.
  // (Note that this demo uses a wider set of styles than the guide below.)
  var style = {
    base: {
      color: '#32325d',
      lineHeight: '24px',
      fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
      fontSmoothing: 'antialiased',
      fontSize: '16px',
      '::placeholder': {
        color: '#aab7c4'
      }
    },
    invalid: {
      color: '#fa755a',
      iconColor: '#fa755a'
    }
  };

  // Create an instance of the card Element
  var card = elements.create('card', {style: style});

  // Add an instance of the card Element into the `card-element` <div>
  card.mount('#card-element');

  // Handle form submission
  var form = document.getElementById('payment-form');

  form.addEventListener('submit', function(event) {
    event.preventDefault();

    var extraDetails = {
      name: form.querySelector('input[name=cardholder-name]').value
    };

    stripe.createToken(card, extraDetails).then(setOutcome);
  });

  function setOutcome(result) {
    var successElement = document.querySelector('.success');
    var errorElement = document.querySelector('.error');
    successElement.classList.remove('visible');
    errorElement.classList.remove('visible');

    if(result.error) {
      errorElement.textContent = result.error.message;
      errorElement.classList.add('visible');
    } else {
      successElement.querySelector('.token').textContent = result.token.id;
      successElement.classList.add('visible');
      stripeTokenHandler(result.token);
    }
  }

  function stripeTokenHandler(token) {
    // Insert the token ID into the form so it gets submitted to the server
    var form = document.getElementById('payment-form');
    var hiddenInput = document.createElement('input');
    hiddenInput.setAttribute('type', 'hidden');
    hiddenInput.setAttribute('name', 'stripeToken');
    hiddenInput.setAttribute('value', token.id);
    form.appendChild(hiddenInput);

    // Submit the form
    form.submit();
  }
};