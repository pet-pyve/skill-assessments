# R for Data Science Revisions

Here are all my revisions based on your feedback - let me know if there's anything else I should change! 

## Report
​​
>1. There are a few places where the statistical reasoning is not well-explained. For example, the decision to remove an "outlier" doesn't seem well supported for your GDP vs CO2 plot. How do you know this is an outlier? What if you put the X and Y axis on a log scale? Would that point still seem like an outlier? Same question regarding the "Energy use vs Continent" plots.

I've changed both of these plots to a log scale now! Honestly, I wasn't super familiar with the best time to apply log transformation - so it was helpful to get this tip and read through some tips on why we do this. I agree that this suits the situation much more than filtering out the larger data points, so have got rid of the outlier filtering.
​
>2. Notebook style. Please hide the code chunks by default to improve readability for non-coders.

I've done this now!
​
>3. For "Year vs CO2 emmisions plot" consider rescaling the X and Y axis. Should these be on a linear scale or would a log scale help visualize the data better?

Have changed this to a log scale too :)
​
>4. Your answer to "Question 8" is incorrect.
​
I think you may have missed the **ranking** idea. You are not looking for the highest mean population across all years, you are looking for the highest mean *ranking* across all years. The ranking should occur within each year. Let me know if you need any additional clarification on this point!

I've changed this answer so it ranks all the countries by populations every year, and then returns the highest average ranking! You were totally correct in assuming I had missed the ranking part of the question - thanks for picking this up! Hoping I've interpreted it correctly this time :)
​
>5. Not everything has to be a graph. Sometimes, it's helpful to represent data as a table, using tools like the [DT](https://rstudio.github.io/DT/) package. This would solve the issue where you kept filtering your data to "not crowd the graph" and it gives users the ability to explore your results. Please add a table in the last question 8 showing the change in life expectancy for all countries using `DT`.

Have added tables instead of graphs for both question 8 & 9 - agree this is far more appropriate.
​
>6. What type of correlation did you use in your analysis? Why did you pick that type? Make sure this is briefly explained in the markdown.

I used Pearson's correlation, and have added an explanation of why to the report - which I'll copy here too.

"Note: throughout this analysis the correlation test we’ll use is ‘Pearson’s correlation’. This is because the relationships we are analyzing seem to be linear (as demonstrated in the scatter plot). Whilst we could choose to use Spearman/Kendall’s correlation (as the relationships seem to also be monotonic) we prefer to use parametric correlations when possible, as they can make use of more information in calculations (eg. mean)."
​
>7. Why did you choose an ANOVA (parametric) vs a Kruskal-Wallis (non-parametric) for "Question 6"? Please briefly defend your choice of parametric vs non-parametric test in the markdown.

In looking into Kruskal-Wallis more, I realised it was more suited than an ANOVA test - so have changed it over! Here's my justification from the report:

"The country is out predictor variable - as this is the variable that influences the result, and the energy use is our outcome variable, as this is what we measure to determine the relationship. Given we have a categorical predictor variable, and a quantitative outcome variable, and we’re comparing multiple groups (countries) with only one outcome variable (how much energy) - we’ll have to choose between an ANOVA test and a Kruskal-Wallis test. ANOVA needs a normal distribution, so let’s visualise

To see if we can get anymore insights about the nature of this relationship - lets observe the shape of the distribution for each of the continents. We’ll also run a Shapiro-Wilk test to give us a statistical confirmation of whether the distribution is normal, if the p value is less than 0.05 - it means its not normal.

[GRAPH HERE]

Overall, we can assume that this distribution isn’t normally distributed by looking at this graph and the p_value of the Shapiro result (9.27e-33), and so will instead opt for the Kruskal-Wallis test."
​
>8. Same as above for "Question 7". Why the t-test (parametric) instead of a Wilcoxon rank sum test (non-parametric)?

As above, in looking into Wilcoxon rank sum test more, I realised it was more suited than a T-Test  - so have changed it over! Here's my justification from the report:

"Given we have a categorical predictor variable, and a quantitative outcome variable, and we’re comparing two groups (Asia & Europe), we’ll have the choice between a T-test and a Wilcoxon rank sum test! Once again, as with ANOVA, a T-test assumes a normal distribution, so we’ll test for that by visualizing it & running a Shapiro-Wilk test.

[GRAPH HERE]

​Overall, we can assume that this distribution isn’t normally distributed by looking at this graph and the p_value of the Shapiro result (0.000129), and so will instead opt for the Wilcoxon test. Wilcoxon will help determine if there is a statistically significant difference between the two groups."

## Code
​
Have run styler on both this, and my R Programming code, so hopefully this should be all good!
