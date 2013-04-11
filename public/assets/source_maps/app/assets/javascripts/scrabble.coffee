window.app =
  selected_channel : null
  pusher: null
  document_ready: ->
    $('body').on('click', '.channel', app.channel_select)
    app.pusher = new Pusher('<%= Pusher.key %>')
  channel_select: ->
    # $('.channel').removeClass('select')
    app.selected_channel.removeClass('select') if app.selected_channel

    if app.selected_channel && (app.selected_channel)[0] == this
      app.selected_channel= null
    else
      app.selected_channel = $(this)
      app.selected_channel.addClass('select_cell')
      app.select_channel(app.selected_cell.text())
  select_channel: (name) ->
    app.pusher.unsubscribe(app.selected_channel) if app.selected_channel
    app.pusher.subscribe(name)
    app.selected_channel = name
    app.bind_events()
  bind_events: ->
    channel = app.pusher.channels.channels[app.selected_channel]
    channel.bind('chat', app.chat)
  chat: (data) ->
    console.log(data)

$(document).ready(app.documet_ready)
