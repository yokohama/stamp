$ ->
  $('#delegateAgreeCheckbox').click ->
    if $('#delegateAgreeCheckbox').is(':checked')
      $('#submit').removeAttr('disabled')
    else
      $('#submit').attr('disabled', 'disabled')
