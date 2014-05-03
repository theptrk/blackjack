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
    @model.get('playerHand').on 'bust', => this.$el.find('.player-hand-container').prepend($('<h2>BUSTED</h2>'))
    @model.get('playerHand').on 'bust', => @disButton(); @dealerPlays()
    @model.get('playerHand').on 'playerStand', => @disButton(); @dealerPlays()

    @render()

  disButton: ->
    this.$el.find('button').attr('disabled', 'disabled')

  dealerPlays: ->
    console.log(@model.get('dealerHand').at(0).flip())
    score = @model.get('dealerHand').scores()
    while score[0] < 17
      @model.get('dealerHand').hit()
      score = @model.get('dealerHand').scores()

    @checkScores()
    #if score[0] < 17 then @model.get('dealerHand').hit()
    #@model.get('dealerHand').set('dealerScore', @model.get('dealerHand').scores())

  checkScores: ->
    playerScore = @model.get('playerHand').scores()
    dealerScore = @model.get('dealerHand').scores()
    console.log(playerScore)
    console.log(dealerScore)
    if playerScore[0] > 21 then return console.log('player bust')
    if dealerScore[0] > 21 then return console.log('dealer bust')
    if playerScore[0] > dealerScore[0] then return console.log('player wins')
    if playerScore[0] == dealerScore[0] then return console.log('push')
    else return console.log('dealer win')

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
