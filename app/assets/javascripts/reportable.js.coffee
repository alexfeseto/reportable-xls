$(document).ready ->
  $("#topnav li a").each ->
    $(this).parent().addClass("active") if $(this).attr("href") is $(location).attr("pathname")

  $("#all-documents").on 'click', '.version-link a', (event) ->
    linkEl = $(this)
    if linkEl.find('i').hasClass('icon-chevron-sign-down')
      $.get linkEl.attr('data-href'), (responseText) ->
        linkEl.parents('.version-link').siblings('.all-versions').html(responseText).show()
        linkEl.find('i').removeClass('icon-chevron-sign-down').addClass('icon-chevron-sign-up')
    else
      linkEl.parents('.version-link').siblings('.all-versions').hide()
      linkEl.find('i').removeClass('icon-chevron-sign-up').addClass('icon-chevron-sign-down')
