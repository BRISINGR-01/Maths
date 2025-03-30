# Research

## Hypothesis: More experienced developers prefer Linux over other OSes

### Gathering the data

For the last 14 years Stackoverflow has been conducting a yearly survey among software developers. The topics of the survey include preferred technologies, working conditions, knowledge and skills level and other technical questions. The sampling method is "Voluntary response", since the developers actively choose to participate.

According to Statista there were approximately 28.7 millions software developers in 2024 of which 65,437 actively participated in the survey. The data was gathered from developers from 185 countries, with the highest percentage being from the USA. However, this percentage is less than 20% followed by 8.4% from Germany and 7.2% from India, so it isn't heavily biased based on nationality. I would consider the result heavily biased if more than half of the participants are from the same country.

I used "actively participated", since the actual number of participants is higher - there is a filtering question in the survey which states "Just checking to make sure you are paying attention to the survey questions. Select ‘Apples’ from the list and you can get back to the survey.". If any answer but "Apples" is provided, then the participant is discarded from the end result of the survey. The aim is to increase the quality of the data by filtering out careless participants and bots.

## Analysis

### 1. Enumerating the data

The data from the survey consists of 3 files:

- A pdf file with the questions
- _survey_results_schema.csv_ containing information about the questions, such as id, long and short name.
- _survey_results_public.csv_ containing the filtered answers given by the participants.

I wrote a script that extracts all unique answers to every question and saves them in a _types.json_ file.

I extracted a 1000 rows from the csv for every type of developer to use as sample in _sample_survey_results.csv_. This classifies as a "Stratified sample" since I used random samples of equal count from all different categories.

### 3. Error Analysis

To evaluate the accuracy of the regression model, I used several error metrics that measure the difference between actual and predicted values. These metrics help assess the model's reliability and indicate areas for improvement.

1. Residuals and Sum of Squared Errors (SSE)  
   The residual for each data point is the difference between the actual and predicted values:

```math
\text{Residual} = y_i - \hat{y}_i
```

A residual close to zero indicates a good prediction. To quantify the total error, I computed the Sum of Squared Errors (SSE):

```math
SSE = \sum (y_i - \hat{y}_i)^2
```

A lower SSE indicates a better fit of the model to the data.

2. Mean Squared Error (MSE)
   The Mean Squared Error (MSE) measures the average squared difference between actual and predicted values:

```math
MSE = \frac{1}{n} \sum (y_i - \hat{y}_i)^2
```

Since it squares the residuals, MSE penalizes larger errors more than smaller ones. A lower MSE indicates a more accurate model.

3. Root Mean Squared Error (RMSE)
   The Root Mean Squared Error (RMSE) is the square root of MSE:

```math
RMSE = \sqrt{MSE}
```

Unlike MSE, RMSE is in the same units as the dependent variable, making it easier to interpret. It provides an intuitive measure of how much error we can expect on average.

4. Mean Absolute Error (MAE)
   The Mean Absolute Error (MAE) measures the average absolute difference between actual and predicted values:

```math
MAE = \frac{1}{n} \sum |y_i - \hat{y}_i|
```

Unlike MSE and RMSE, MAE does not square the errors, making it less sensitive to outliers. A lower MAE indicates a better model fit.

5. Coefficient of Determination (
   𝑅
   2
   R
   2
   )
   The
   𝑅
   2
   R
   2
   score measures how well the independent variable explains the variance in the dependent variable:

```math
R^2 = 1 - \frac{\sum (y_i - \hat{y}_i)^2}{\sum (y_i - \bar{y})^2}
```

​

where
𝑦
ˉ
y
ˉ
​
is the mean of the actual values.

𝑅
2
=

1
R
2
=1 indicates a perfect fit.

𝑅
2
=

0
R
2
=0 means the model does not explain the variation.

𝑅
2
<
0
R
2
<0 suggests the model performs worse than a horizontal line.

6. Interpretation of Error Metrics
   Low RMSE and MSE indicate that the model's predictions are close to the actual values.

MAE provides an intuitive measure of typical prediction error.

A high
𝑅
2
R
2
value suggests the model explains most of the variance in the data.

Discrepancies between MSE and MAE suggest the presence of outliers affecting squared error measures.

By analyzing these metrics, we assess whether our model sufficiently explains the relationship between developer experience and Linux preference. If errors are high or
𝑅
2
R
2
is low, additional factors (such as job role or industry) may need to be incorporated into the model.

## References

- Statista - <https://www.statista.com/statistics/627312/worldwide-developer-population/>
- Stackoverflow's 2024 survey - <https://survey.stackoverflow.co/2024/>

```

```
