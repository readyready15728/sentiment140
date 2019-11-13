# Sentiment140
## Sentiment analysis of the Sentiment140 Twitter dataset

This is a foray into machine learning using Ruby rather than the perennial
favorites of Python and R. (Python is a fine language! I just like Ruby more.
And R? ... Well it has all these nice packages that minimize contact with the
language *per se* so there's that.) The task is labeling tweets as positive or
negative based on a modified version of the Sentiment140 dataset. The original
dataset had quite a few tweets with invalid Unicode that made Ruby's CSV
library choke, and so had to be removed, and a very small test set with
neutral tweets with no kind of representation in the training data. Very
unfair to expect good performance on that! What I have done instead is
shuffled the scrubbed training set so that positive and negative tweets are
represented well in both training and test data, the latter taken from the
tail end of the file.

The initial effort was with a pre-trained model used by Ruby library
[sentimental](https://github.com/7compass/sentimental) but—no offense to the
author—this did not prove up to my needs.  I eventually chose to use naïve
Bayes for this task and looked into Ruby solutions and found
[nbayes](https://github.com/oasic/nbayes) which seemed simple enough, although
the classification phase was very slow. I chose a 95%/5% train/test split for
no other reason that said phase was so arse-paralyzingly slow. (Might try
again with a traditional 80%/20% split and just wait at some point but it
probably won't change much.)

But what was the outcome? About 78.6% accuracy, which seems dismal in a world
where artificial intelligences now regularly achieve superhuman performance on
specific tasks. But consider the [most up-voted Kaggle kernel on the same
dataset](https://www.kaggle.com/paoloripamonti/twitter-sentiment-analysis):
look at all the extra effort this guy put in with feature engineering and deep
learning and all he got was a boost in accuracy of about 0.5%. Sometimes the
extra effort really isn't worth putting in.

To run the code, extract `tweets.csv` (`unxz` works fine on Unix systems)
because GitHub doesn't like files larger than 100 MB and do `[sudo] gem
install nbayes`. Then do `ruby predict.rb` and wait.
