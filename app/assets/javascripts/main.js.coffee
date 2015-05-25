$ ->
  $('body').on 'click', '.js-next', ->

    $(this).on 'ajax:success', (evt, response) ->
      $(this).closest('tr').remove()

      $('tbody').append(response)

  $('.left_side table thead span').tipsy
    gravity: 's'

  $('.favicon').tipsy
    gravity: 'w'

  return
