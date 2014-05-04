#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'game', game = new Game()
    # @set 'playerHand', deck.dealPlayer()
    # @set 'dealerHand', deck.dealDealer()
    # @set 'playerBust', false
    # @set 'playerStand', false
    # @get('playerHand').on 'bust', => @set 'playerBust', true
    # @get('playerHand').on 'playerStand', => @set 'playerStand', true
  event: ->

  newGame: ->
    @set 'game', game = new Game()
    @trigger 'restart', @
