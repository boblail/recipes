$ ->
  $('.rating').change ->
    $input = $(@)
    $form = $input.closest('form')
    url = $form.attr('action') + '/ratings'
    
    $.put url,
      name: $input.attr('name')
      value: $input.val()
