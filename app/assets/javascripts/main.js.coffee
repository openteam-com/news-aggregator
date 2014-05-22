$ ->
  $("#dialog").dialog
    width: 500
    autoOpen: false
    draggable: false
    modal: true

  $(".open_form_link").click ->
    $("#dialog").dialog "open"
    $(".new_suggested_entry").append("<input type='hidden' value='"+$(this).attr("id")+"' name='suggested_entry[entry_type]'>")
    return

  $("body").on "click", ".ui-widget-overlay", ->
    $("#dialog").dialog "close"

  $('body').on 'click', '.js-next', ->

    $(this).on 'ajax:success', (evt, response) ->
      $(this).closest('tr').remove()

      $('tbody').append(response)

  $('.left_side table thead span').tipsy
    gravity: 's'

  return
