Working with text
library(tidyverse)
library(stringr)

#quotation

cat("hello")

cat("hello\tWorld")

cat ("hello\nWorld") #print world on another line

ds <- tibble(x = c("ice\ncream", "race\ncar"), y = c(10,20))
ggplot() + geom_bar(x=x, y=y)

#common string functions
str_length(c("a", "R for us", NA, ""))

#To combine two or more strings, use str_c():
str_c("x", "y", "z")
str_c("x", "y", "z ", sep = ", ")

#Function str_c() is vectorised:

str_c("STAT", c(266, 267))
str_c("STAT", c(266, 267), collapse=", ")

#Question: Can we use both sep and collapse in the same str_c()?
str_c("STAT", c(266, 267), sep= " ", collapse=", ")
str_c("STAT", c(266, 267, 361,362), sep= " ", collapse=", ")

#To extract parts of a string, use str_sub(), which takes start and end arguments for the (inclusive) positions
x <- c("Apple", "Banana" , "Pear")
str_sub(x, 1, 3)
str_sub(x, -3, -1)

str_sub(x,-3,-1) #it goes to apple - starts from ple and for banana - ana , 

#Can also use assignment form of str_sub() to modify strings:
str_sub(x,1,1) <- str_to_lower(str_sub(x,1,1))
x
str_sub(x,1,1) <- str_to_upper(str_sub(x,1,1))
x

#Question: What happens if the end argument is more than the length of a string?
#it will go all the way to the string

#Question: Use str_length() and str_sub() to extract the middle character from a string.
str_sub(x, floor(str_length(x)/2),
        ceiling(str_length(x)/2))

#give middle letter
x <- c("apple")
str_sub(x, -3, -3)

#regular expression


#Regular expression (regexp) allows to describe patterns in strings

#Hard to learn but extremely useful

#stringr has the function str_view() and str_view_all() to show you how strings and patterns match.
#Example:
X <- c("apple","banana", "pear")
str_view(X, "an")

#Question: What dose the dot mean in the following?
str_view(X, ".a.") #apple is not part of .a. 

#basic pattern matching
#Question: Come up with the regular expression to match a literal \ and the string to represent the regexp
cat("\\.csv")

cat("\\\\") #to represent two backslash

#Question: What patterns will the regexp \..\..\.. match?
.b.c.b

#Question: How do you represent the above regexp as a string?
cat("\\..\\..\\..")


#RegExp - Anchors
#By default, regular expression will match any part of a string.
#Use ^ to match the start of the string.
#Use $ to match the end of the string.
x <- c("apple", "banana", "pear")
str_view(x, "^a")
str_view(x, "a$")

#Question: How to force a regular expression to only match a complete string? Example: “apple” from
x <- c("apple pie", "apple", "apple cake")
str_view(x, "^apple$")


#Character classes and alternatives
#\d matches any digit
#\s matches any whitespace (e.g., space, tab, newline)
#[abc] matches a, b, c
#[^abc] matches anything except a, b, c
#Can use square brackets for literal special characters.
x <- c("abc", "a.c", "a*c", "a c")
str_view(x, "a[.]c")
str_view(x, ".[*]c")
str_view(x, "a[ ]")

#Can use dash for a range. E.g., [a-m0-9]
str_view(x,"[a-m0-9]")

#Example: abc|d..f will match either "abc" or "deaf"
#But abc|xyz won't match abcxy or abxyz
#Use parentheses to make it easy to understand
str_view(c("grey", "gray"), "gr(e|a)y")

#Question: Create regular expressions to find words that
#Start with a vowel
  #regular expression ^(a|e|i|o|u)  or ^[aeiou]

#End with ed, but not with eed.
 # ^[^e]ed$

#End with ing or ise.
 # (ing|ise)$

#in class Exerciese
#The corpus of common words is stored in the data set words (in the stringr package).
#Create a regular expression that find all words that are exactly three letters long.
# regular expression ^...$

#When use str_view(), set match = TRUE to display only matched word
str_view(words, "^...$", match = TRUE)

#Verify empirically the rule “i before e except after c”?
str_view(words, "cie", match = TRUE)
 # it is not really true 

# Repetition in regular expressions

#Control how many times a pattern matches:
# ? matches 0 or 1 time
# + matches 1 or more times
# * matches 0 or more times

x <- "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"
str_view(x, "CC?")
str_view(x, "CC+")
str_view(x, "C[LX]+")
str_view(x, "CC[LX]+")
str_view(x, "C[LX+]")
str_view(x, "CC*")

Y <- "MCI"
str_view(Y, "CC?")


#Specify the number of matches precisely:
# {n} matches exactly n times
# {n, } matches n or more times
# { ,m} matches at most m times
# {n, m} matches between n and m times.
# Example with "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"

str_view(x, "C{2}")
str_view(x, "C{2,}")
str_view(x, "X{1,2}")
str_view(x, "C{2, 3}")

# By default, the result will be the longest possible match. For the shortest match, put ? after them

# Repetition – In-class Exercise
# Describe in words what these regular expressions match:
# (read carefully to see if I am using a regular expression or a string that defines a regular expression.)

str_view(x, "^.*$")
# it matches all

str_view(x, "\\{.+\\}")
# regular expression : \{.+\}
# it matches anything

str_view(x, "\d{4}-\d{2}-\d{2}")
# regular expression : #### - ## - ##
# matches 4 digits then 2 digits and then 3 digits 

str_view(x, "\\\\{4}")
# regular expression : \\{4}
# matches with \\\\ (four single backslashes)

# Create regular expressions to find all the (10-digit) phone numbers.
#812 488 1161 ->  \d{3}\d{3}\d{4}

# regular expression for (812) 488 1161
# \(?\d{3}\[ -]?\d{3}[ -]?\d{4})
x <- (8125684490)
str_view(x, "\\(?\\d{3}\\)?[ -]?\\d{3}[ -]?\\d{4}")


str_view(fruit, "(..)\\1", match = TRUE)
str_view(fruit, "(.)\1\1")

## detect matches

# Function str_detect() return TRUE if pattern matches
x <- c("apple", "banana", "pear")
str_detect(x, "e")

# Can take advantage of numeric conversion of logical values to do computation

sum(str_detect(words, "^t"))
mean(str_detect(words, "[aeiou]$")) ## give the proportion that ends with vowels

# or extract the detected words with str_subset()
str_subset(words, "x$")

##Extract matches

# str_extract() and str_extract_all() allow us to extract the actual text of a match.
# Example: Harvard sentences used in testing of VOIP system
length(sentences)
head(sentences)

# Task: Find all sentences that contain a colour.
colours <- c("red", "orange", "yellow", "green", "blue", "purple")
colour_match<- str_c(colours,collapse="|") #collapase "|" that mean "or"
colour_match

# Question: What is the usage of color_match?



## more examples 
has_colour <- str_subset(sentences, colour_match)
matches <- str_extract(has_colour, colour_match)
head(matches)

str_view(sentences, colour_match, match = TRUE)

# Question: 
# In the previous example, you might have noticed that the regular expression matched “reared”, which is not a colour. 
# Modify the regex to fix the problem.

colours <- c("red", "orange", "yellow", "green", "blue", "purple")
colour_match<- str_c(" ",colours)
colour_match

has_colour <- str_subset(sentences, colour_match)
matches <- str_extract(has_colour, colour_match)
head(matches)

str_view(sentences, colour_match, match = TRUE)


## Replacing matches
# str_replace() and str_replace_all() allow you to replace matches with new strings
x <- c("apple", "pear", "banana")
str_replace(x, "[aeiou]", "-") ## only replace one vowel from the word with -
str_replace_all(x, "[aeiou]", "-") ## replace all the vowels from the word with -

#str_replace_all() allows multiple replacements by supplying a named vector
x <- c("1 house", "2 cars", "3 people")
str_replace_all(x, c("1" = "one", "2" = "two", "3" = "three"))

# Deletion is equivalent to replace a pattern with an empty string (i.e., "")
# It is better to use str_remove() or str_remove_all() for deletion.
# str_replace() allow usage of backreferences to insert components of the match

sentences %>% 
  str_replace("([^ ]+) ([^ ]+) ([^ ]+)", 
              "\\1 \\3 \\2") %>% 
  head(5)

# Question: Switch the first and last letters in words. Which of those strings are still words?
words %>% 
  str_replace("^([a-z|A-Z])(.*)([a-z|A-Z])$",
              "\\3\\2\\1") -> new_word
new_word[new_word %in% words ]

# or
words %>% 
  str_replace("^(.)(.*)(.)$",    ## dot represent everything from lower case letter to upper case letter
              "\\3\\2\\1") -> new_word
new_word[new_word %in% words ]

## splitting
#str_split() splits a string up into pieces.
sentences %>%
  head(5) %>% 
  str_split(" ")

#Use the argument simplify = TRUE to convert the results into data frame.
sentences %>% 
  head(5) %>% 
  str_split(" ", simplify = TRUE)

# Instead of splitting up strings by patterns, you can also split up by character, line, sentence and word boundary, 
# e.g., using boundary(“word”)for word

## Miscellaneous

# To match a specific sequence of character, use fixed() to speed up the performance (up to 3x faster than the regular expression)
# str_locate() and str_locate_all() give you the starting and ending positions of each match.
# str_to_lower() and str_to_upper() convert letters in strings into their lower- and uppercases, respectively.
# str_trim() removes space in front and at the end of the string
# str_squish() reduces repeated whitespace inside a string.


## in_class exercises

# idea : replace "high" to high school and "HS" to high school too. then do inner_join to join the tables 

# It is often a case where you need to join two tables where the key identifiers are name in string format. 
# Download the two tables from the Blackboard
# Manipulate the column “County” from both tables so that the following code joins the tables: 

inner_join(table_1, table_2, by = “County”)

# You are allowed to use string operations (e.g., replacement, deletions, etc.) only.
