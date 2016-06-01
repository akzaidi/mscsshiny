library(mscsweblm4r)
vignette("mscsweblm4r_vignette", package = "mscsweblm4r")
# configure your API keys with webml
# save webLM credentials in user directory with .mscskeys.json
# https: / / www.microsoft.com / cognitive - services / en - us / subscriptions
weblmInit()

# example 1
# http://philferriere.blogspot.com/2016/05/using-microsoft-cognitive-services-web.html


tryCatch({

    # Generate next words
    weblmGenerateNextWords(
    precedingWords = "how are you", # ASCII only
    modelToUse = "title", # "title"|"anchor"|"query"(default)|"body"
    orderOfNgram = 4L, # 1L|2L|3L|4L|5L(default)
    maxNumOfCandidatesReturned = 5L # Default: 5L
    )

}, error = function(err) {

    # Print error
    geterrmessage()

})

# Retrieve a list of supported web language models
weblmListAvailableModels()

# Break a string of concatenated words into individual words
weblmBreakIntoWords(
    "testforwordbreak", # ASCII only
    modelToUse = "body", # "title"|"anchor"|"query"(default)|"body"
    orderOfNgram = 5L, # 1L|2L|3L|4L|5L(default)
    maxNumOfCandidatesReturned = 5L # Default: 5L
    )


tryCatch({

    # Calculate conditional probability a particular word will follow a given sequence of words
    conditionalProbabilities <- weblmCalculateConditionalProbability(
     precedingWords = "hello world wide", # ASCII only
     continuations = c("web", "range", "open"), # ASCII only
     modelToUse = "title", # "title"|"anchor"|"query"(default)|"body"
     orderOfNgram = 4L # 1L|2L|3L|4L|5L(default)
     )

    # Class and structure of conditionalProbabilities
    class(conditionalProbabilities)
    #> [1] "weblm"

    str(conditionalProbabilities, max.level = 1)
    #> List of 3
    #>  $ results:'data.frame':  3 obs. of  3 variables:
    #>  $ json   : chr "{"results":[{"words":"hello world wide","word":"web", __truncated__ }]}
    #>  $ request:List of 7
    #>   ..- attr(*, "class")= chr "request"
    #>  - attr(*, "class")= chr "weblm"

    # Print results
    pandoc.table(conditionalProbabilities$results)
    #> -------------------------------------
    #>      words        word   probability
    #> ---------------- ------ -------------
    #> hello world wide   web      -0.32
    #>
    #> hello world wide range     -2.403
    #>
    #> hello world wide  open      -2.97
    #> -------------------------------------

}, error = function(err) {

    # Print error
    geterrmessage()

})
