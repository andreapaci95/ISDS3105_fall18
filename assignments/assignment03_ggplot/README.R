#' ---
#' title: "Assingment 3"
#' author: ""
#' output: github_document
#' ---

#' For this assignment we are using a dataset from the website [Fivethirtyeight](http://fivethirtyeight.com/). 
#' All these datasets are available on their [GitHub page](https://github.com/fivethirtyeight/data/) and in the `fivethirtyeight` package.
#' The final sumbission will be an RMarkdown report.
#' 


#' 1. Install and load the `fivethirtyeight` library. For this assigment we are using the dataset `bad_drivers`.
install.packages('fivethirtyeight')
library(fivethirtyeight)
bad_drivers
#' 2. In the narrative, add a brief description (`?bad_drivers` for a description of the dataset) using *inline code* to show the variable names.
names(bad_drivers)
#' 3. Plot a dot chart of premiums by losses. Map the count of drivers to the size of the dots.
library(ggplot2)
ggplot(data = bad_drivers, aes(insurance_premiums, losses)) + geom_point(aes(size = num_drivers))
#' 4. Test what values from `state` are equal to "Louisiana" and assign the output to a new variable called `Louisiana' (logical)
bad_drivers$Louisiana <- bad_drivers$state=='Louisiana'
#' 5. Map the variable "Louisiana" to `color`. That way, the dot referring to Louisiana should have a different color.
ggplot(data = bad_drivers, aes(insurance_premiums, losses)) + geom_point(aes(size = num_drivers, color=Louisiana))
#' 6. In your narrative, use inline code to report the average insurance premium and count of losses in US, and the premium and losses in Louisiana. Do not type those values manually, but extract them from the dataset using inline code.
mean(bad_drivers$insurance_premiums)
mean(bad_drivers$losses)
as.double(bad_drivers[bad_drivers$state=='Louisiana', "insurance_premiums"])
as.double(bad_drivers[bad_drivers$state=='Louisiana', "losses"])
#' 7. Report in a tabular format the 5 states with the highest premiums (include only state and insurance_premiums)
bad_drivers_sorted_premium <- bad_drivers[order(-bad_drivers$insurance_premiums),]
bad_drivers_sorted_premium[1:5,c("state","insurance_premiums")]
#' 8. Reshape the dataset gathering together perc_speeding, perc_alcohol, perc_not_distracted in one variable, paired with their pecentages. Name this variable "ViolationType" and the variable for the value pairs "perc".
library(tidyr)
bad_drivers_reshaped <- gather(bad_drivers, ViolationType, perc, perc_speeding:perc_not_distracted)
#' 9. Use facetting (DO NOT use 3 distinct calls to `ggplot()`) to plot 3 dot plots for the correlation between:
#'   - insurance_premiums and perc_alcohol
#'   - insurance_premiums and perc_speeding
#'   - insurance_premiums and perc_not_distracted
ggplot(bad_drivers_reshaped) + geom_point(aes(insurance_premiums, perc)) + facet_wrap(~ViolationType, scales='free')
#' 10. Mute the code for both charts and add a title to both. Knit to html.
ggplot(bad_drivers_reshaped, aes(bad_drivers_reshaped$insurance_premiums, bad_drivers_reshaped$perc,)) +
geom_point(aes(color=ViolationType)) + ggtitle("Insurance premiums by percentage of ViolationType")

ggplot(bad_drivers_reshaped) + geom_point(aes(insurance_premiums, perc)) + facet_wrap(~ViolationType, scales='free') +
 ggtitle(label = "Insurance premiums by different Violation Types")



