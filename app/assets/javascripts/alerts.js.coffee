$ ->
  $(".close-parent").click ->
    $(".close-parent").parent().parent().hide()

    false
return
