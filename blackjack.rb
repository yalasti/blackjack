def calculate_total(cards) 
  # [['H', '3'], ['S', 'Q'], ... ]
  arr = cards.map{|e| e[1] }

  total = 0
  arr.each do |value|
    if value == "Ace"
      total += 11
    elsif value.to_i == 0 # Jack, Queen, King
      total += 10
    else
      total += value.to_i
    end
  end

  #correct for Aces
  arr.select{|e| e == "Ace"}.count.times do
    total -= 10 if total > 21
  end

  total
end

# Start Game

puts "Let's play Blackjack!"

suits = ['Hearts', 'Diamonds', 'Spades', 'Clubs']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']

deck = suits.product(cards)
deck.shuffle!

# Deal Cards

playercards = []
dealercards = []

playercards << deck.pop
dealercards << deck.pop
playercards << deck.pop
dealercards << deck.pop

dealertotal = calculate_total(dealercards)
playertotal = calculate_total(playercards)

# Show Cards

puts "Dealer cards are: #{dealercards[0]} and #{dealercards[1]}, for a total of #{dealertotal}"
puts "You cards are: #{playercards[0]} and #{playercards[1]}, for a total of: #{playertotal}"
puts ""

# Player turn
if playertotal == 21
  puts "You win!"
  puts"Game Over"
  exit
end

while playertotal < 21
  puts "What would you like to do? 1) hit 2) stay"
  hit_or_stay = gets.chomp

  if !['1', '2'].include?(hit_or_stay)
    puts "Error: you must enter 1 or 2"
    next
  end

  if hit_or_stay == "2"
    puts "You chose to stay."
    break
  end

  #hit
  new_card = deck.pop
  puts "Dealing card to player: #{new_card}"
  playercards << new_card
  playertotal = calculate_total(playercards)
  puts "Your total is now: #{playertotal}"

  if playertotal == 21
    puts "You win!"
    puts "Game Over"
    exit
  elsif playertotal > 21
    puts "You busted! Dealer win!"
    puts "Game Over"
    exit
  end
end

# Dealer turn
if dealertotal == 21
  puts "Dealer win!"
  puts "Game Over"
  exit
end

while dealertotal < 17
  #hit
  new_card = deck.pop
  puts "Dealing new card for dealer: #{new_card}"
  dealercards << new_card
  dealertotal = calculate_total(dealercards)
  puts "Dealer total is now: #{dealertotal}"

  if dealertotal == 21
    puts "Dealer win!"
    puts "Game Over"
    exit
  elsif dealertotal > 21
    puts "Dealer busted! You win!"
    puts "Game Over"
    exit
  end
end

# Check hands
puts "Dealer's cards: "
dealercards.each do |card|
  puts "=> #{card}"
end
puts ""

puts "Your cards:"
playercards.each do |card|
  puts "=> #{card}"
end
puts ""

if dealertotal > playertotal
  puts "Dealer wins."
  puts "Game Over"
elsif dealertotal < playertotal
  puts "You win!"
  puts "Game Over"
else
  puts "It's a tie!"
  puts "Game Over"
end

exit