$.fn.set_locale = ->
  I18n.locale = $('html').attr('lang')
  I18n.defaultLocale = $('html').attr('lang')

$ ->  
  $.fn.set_locale()