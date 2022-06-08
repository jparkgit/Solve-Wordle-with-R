solve <- function(num=5){
    require("RCurl")
    require("dplyr")
    download <- getURL("https://raw.githubusercontent.com/jparkgit/Solve-Wordle-with-R/main/words_with_count_df.csv")
    data <- read.csv(text = download)

    dic <- data
    dic['1'] <- substr(dic$word,1,1)
    dic['2'] <- substr(dic$word,2,2)
    dic['3'] <- substr(dic$word,3,3)
    dic['4'] <- substr(dic$word,4,4)
    dic['5'] <- substr(dic$word,5,5)

    temp <- dic

    sol=1
    while(sol<=num){ 
        word = readline('Enter word (control+c to quit anytime):')
        word=strsplit(word,"")
        word=word[[1]]
        while(length(word)!=5){
            print('Error: enter a five letter word')
            word = readline('Retry:')
            word=strsplit(word,"")
            word=word[[1]]
            if(length(word)==5){
                break
            }
        }
        match_info = readline('Enter match results (o: green, x: gray, y: yellow):')
        match=strsplit(match_info,"")
        match=match[[1]]
        guess <- data.frame(word, match)
    
        for(i in 1:5){
            if(guess[i,2] == 'o'){
                temp <- subset(temp, temp[,i+2] == guess[i,1])
            }
            else if(guess[i,2] == 'x'){ 
                temp <- filter(temp, !grepl(guess[i,1],word))
            }
            else if(guess[i,2] == 'y'){ 
                temp <- filter(temp, grepl(guess[i,1],word))
                temp <- subset(temp, temp[,i+2] != guess[i,1])
            }
        }
        sorted <- temp[order(-temp$count),]
        hundred <- head(sorted$word,100)
        
        if(length(hundred)==0){
            print("Sorry, No matching words")
        }
        else{
            print(hundred)
        }
        sol=sol+1
    }
}
