class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()

  initialize: ->
    @model.get('playerHand').on 'bust', => console.log(this.$el.find('.player-hand-container').prepend(
      $('<h2>BUSTED</h2>')))
    @model.get('playerHand').on 'bust', => console.log(this.$el.find('.hit-button').attr('disabled', 'disabled'))
    #@model.on 'bust:changed', => $('.player-hand-container').append($('<span>BUSTED</span>'))
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
