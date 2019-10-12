require 'csv'
require 'nbayes'

def get_sentiment(code)
  case code.to_i
    when 0
      :negative
    when 2
      :neutral
    when 4
      :positive
  end
end

nbayes = NBayes::Base.new
line_count = File.foreach('tweets.csv').count
test_train_cutoff = (line_count * 0.95).to_i
sentiment_pair_counts = Hash.new 0

CSV.foreach('tweets.csv').with_index(1) do |row, i|
  if i % 100 == 0
    puts i
  end

  if i < test_train_cutoff
    sentiment = get_sentiment(row[0])
    nbayes.train(row[-1].split(/\s+/), sentiment)
  else
    real_sentiment = get_sentiment(row[0])
    actual_sentiment = nbayes.classify(row[-1].split(/\s+/)).max_class
    sentiment_pair_counts[[real_sentiment, actual_sentiment]] += 1
  end
end

p sentiment_pair_counts
