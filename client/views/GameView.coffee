class window.GameView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()

  initialize: ->
    console.log(@)
    @model.get('playerHand').on 'bust', => @showBusted(); @model.checkScores()
    @model.get('playerHand').on 'bust', => @disButton()
    @model.get('playerHand').on 'playerStand', => @disButton()
    # @model.on 'playerHasBust', => @showBusted()
    @model.on 'dealerHasBust', => @showDealerBusted()
    @model.on 'playerHasWon', => @showPlayerWon()
    @model.on 'push', => @showPush()
    @model.on 'dealerHasWon', => @showDealerWon()


    @render()

  showBusted: ->
    @$el.find('.player-hand-container').prepend($('<h2>PLAYER BUSTED</h2>'))

  showDealerBusted: ->
    @$el.find('.player-hand-container').prepend($('<h2>DEALER BUSTED</h2>'))

  showPlayerWon: ->
    @$el.find('.player-hand-container').prepend($('<h2>PLAYER WON</h2>'))

  showPush: ->
    @$el.find('.player-hand-container').prepend($('<h2>PUSH</h2>'))

  showDealerWon: ->
    @$el.find('.player-hand-container').prepend($('<h2>DEALER WON</h2>'))


  disButton: ->
    @$el.find('button').attr('disabled', 'disabled')

  # checkScores: ->
  #   playerScore = @model.get('playerHand').scores()
  #   dealerScore = @model.get('dealerHand').scores()
  #   console.log(playerScore)
  #   console.log(dealerScore)
  #   if playerScore[0] > 21 then console.log('player bust')
  #   else if dealerScore[0] > 21 then console.log('dealer bust')
  #   else if playerScore[0] > dealerScore[0] then console.log('player wins')
  #   else if playerScore[0] == dealerScore[0] then console.log('push')
  #   else console.log('dealer win')

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

