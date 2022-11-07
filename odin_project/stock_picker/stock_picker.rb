def stock_picker(prices)
  min_price = 0
  max_price = 0
  max_profit = 0

  prices.each_with_index do |buy_price, idx|
    prices[idx + 1..].each do |sell_price|
      profit = sell_price - buy_price
      next if profit < max_profit

      min_price = buy_price
      max_price = sell_price
      max_profit = profit
    end
  end
  [prices.index(min_price), prices.index(max_price)]
end
