# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  # 隱藏所有paginator
  $('.paginator').hide()
  # 設定初始的捲過最大位置
  maxPosition = 10
  $(window).scroll ->
    # 記錄捲過的最大位置，以免往回捲的時候也invoke
    maxPosition = $(window).scrollTop() + window.innerHeight if $(window).scrollTop() + window.innerHeight > maxPosition
    # 設定目前active的tab底下的pagination作為要點的next_link
    paginator = $('.next a').eq(0)
    #console.log $(window).scrollTop() + window.innerHeight + 50 > paginator.position().top
    #console.log paginator.data('infiniteScroll') is true
    # 當頁面已捲高度+瀏覽器視窗高度+buffer值 > next_link的位置 以及 next_link沒被點過
    if $(window).scrollTop() + window.innerHeight + 50 > paginator.position().top and paginator.data('infiniteScroll') isnt 'clicked'
      # 點擊next_link並標示已點過
      paginator.click()
      paginator.data('infiniteScroll', 'clicked')