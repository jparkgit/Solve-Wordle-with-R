wordsfreq <- read.csv("/your_file_path_here/unigram_freq.csv", header=TRUE, stringsAsFactors=FALSE)
download <- getURL("https://raw.githubusercontent.com/tabatkins/wordle-list/main/words")
wordlewords <- read.csv(text = download, header=FALSE)

df <-  wordsfreq[wordsfreq$word %in% wordlewords[,1],]
head(df)
dim(df)
# [1] 8072    2
# 12947-8072=4875 was not selected, they do not have info on frequency
# Add them to the df

# vector containing ids to remove
selected <- df$word

# subset df by rows where wordlewords are not found 
# in the list of already selected words
data[!data[, "ParticipantsIDs"] %in% unlist(ListtoRemove), ]
unselected <- wordlewords[!wordlewords[,1] %in% unlist(selected), ]
length(unselected)
# 4875

# Combiened, complete df
words_with_count_df <- data.frame(
    word = c(df$word, unselected),
    count = as.numeric(c(df$count, rep(0, length(unselected))))
)
dim(words_with_count_df)
#[1] 12947     2

#check for duplicates, just in case
sum(duplicated(words_with_count_df$word))
#[1] 0