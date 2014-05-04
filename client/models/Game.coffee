#todo: refactor to have a game beneath the outer blackjack model
class window.Game extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('dealerHand').on 'dealerReturn', => @checkScores()
    @get('playerHand').on 'playerStand', =>
      @get('dealerHand').first().flip()
      @get('dealerHand').dealerPlay()

  event: ->

  checkScores: ->
    playerScore = @get('playerHand').scores()
    dealerScore = @get('dealerHand').scores()
    console.log(playerScore)
    console.log(dealerScore)
    if playerScore[0] > 21 then @trigger 'playerHasBust', @ #console.log('player bust')
    else if dealerScore[0] > 21 then @trigger 'dealerHasBust', @ #console.log('dealer bust')
    else if playerScore[0] > dealerScore[0] then @trigger 'playerHasWon', @ #console.log('player wins')
    else if playerScore[0] == dealerScore[0] then @trigger 'push', @ #console.log('push')
    else @trigger 'dealerHasWon', @ #console.log('dealer win')
