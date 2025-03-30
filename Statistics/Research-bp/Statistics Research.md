# Research
More experienced developers enjoy contributing to Open Source projects
## Hypothesis
###### **Null Hypothesis**: There is no significant relationship between developer experience and contribution to open source.
$$H_0: m = 0$$
##### **Alternative Hypothesis**: More experienced developers are more likely to contribute to open source.
$$H_a: m > 1$$
Where m is the slope.
## Gathering the data

For the last 14 years Stackoverflow has been conducting a yearly survey among software developers. The topics of the survey include preferred technologies, working conditions, knowledge and skills level and other technical questions. The sampling method is "Voluntary response", since the developers actively choose to participate.

According to Statista there were approximately 28.7 millions software developers in 2024 of which 65,437 actively participated in the survey. The data was gathered from developers from 185 countries, with the highest percentage being from the USA. However, this percentage is less than 20% followed by 8.4% from Germany and 7.2% from India, so it isn't heavily biased based on nationality. I would consider the result heavily biased if more than half of the participants are from the same country.

I used "actively participated", since the actual number of participants is higher - there is a filtering question in the survey which states "Just checking to make sure you are paying attention to the survey questions. Select ‘Apples’ from the list and you can get back to the survey.". If any answer but "Apples" is provided, then the participant is discarded from the end result of the survey. The aim is to increase the quality of the data by filtering out careless participants and bots.
#### Enumerating the data

The data from the survey consists of 3 files:
- A pdf file with the questions
- _survey_results_schema.csv_ containing information about the questions, such as id, long and short name.
- _survey_results_public.csv_ containing the filtered answers given by the participants.

I wrote a script that extracts all unique answers to every question and saves them in a _types.json_ file.

I extracted a 10000 rows from the csv for every type of developer to use as sample in _sample_survey_results.csv_. This classifies as a "Stratified sample" since I used random samples of equal count from all different categories. 
The categories are as follows:
- "I am a developer by profession"
- "I am learning to code"
- "I code primarily as a hobby"
- "I am not primarily a developer, but I write code sometimes as part of my work/studies"
- "I used to be a developer by profession, but no longer am"
I decided to to use this sampling method to minimize the bias towards seasoned or junior developers.

From the separated data I extracted the amount of years spent coding professionally as *x* (independent variable with range 0-50) and satisfaction of contributing to open source as *y* (dependent variable with range 0-100).
To filter out invalid or missing data I discarded points where *x* or *y* equals 0 with the aim to improve overall data quality. 


## Analysis
In the context of this research *x* is the amount of years the participants have programmed professionally and *y* is their satisfaction of contributing to open source. 
### 1. X
The descriptive statistics for **X** provide a comprehensive overview of its distribution. The **minimum** value observed is **1**, while the **maximum** is **50**, resulting in a **range** of **49**. The **mean** value, representing the central tendency, is **10**, which is slightly higher than the **median** of **8**, suggesting a potential right-skewed distribution, further proven on the picture below. The **mode**, the most frequently occurring value, is **3**. The **first quartile (Q₁)** is **4**, and the **third quartile (Q₃)** is **15**, leading to an **interquartile range (IQR)** of **11**, indicating moderate spread within the central 50% of data points. Several **outliers** have been detected beyond the expected range, specifically values **32 to 45**, and **50**, which could significantly impact statistical measures such as variance and standard deviation. I calculated them using the 1.5 IQR rule - any data point that's 1.5 IQR points below the first quartile of data or above the third quartile is an outlier. Additionally, the dataset has a **standard deviation (δ)** of **8.43**.
$$
\delta = \sqrt{\frac{\sum{(x_i - \mu)^2}}{n-1}}
$$
Where mu is the mean and n is the number of data points. I divide by n - 1, because I am using a sample which improves accuracy.
$$min = 1 \ \ \ \ max = 50 \ \ \ \ range = 49 \ \ \ \ mean = 10 \ \ \ \ median = 8 \ \ \ \ mode = 3 \ \ \ \ \delta = 8.427941039114618$$
$$q_1 = 4 \ \ \ \ q_3 = 15 \ \ \ \ IQR = 11 \ \ \ \ outliers = 32,33,34,35,36,37,38,39,40,41,42,43,44,45,50$$
![[Pasted image 20250329205016.png]]
![[Pasted image 20250329233833.png]]
### 2. Y
The dataset for **Y** spans from **1 to 100**, with a **range of 99**, indicating a wide spread of values. The **mean** is **31**, while the **median** is **20**, suggesting a right-skewed distribution. However, the distribution of **Y** shows noticeable spikes around round numbers and multiples of five, suggesting a human bias in number selection. When respondents are given a scale from **1** to **100**, they tend to favor familiar, easily divisible numbers such as **10**, **20**, **25**, **50**, **75**, and **100**. This clustering effect can introduce artificial patterns in the data, making it less organically distributed. Such biases should be considered when interpreting the dataset, as they might not reflect a truly continuous distribution but rather a psychological preference in numerical choices. Separately, I divided all values by 10 to simulate the distribution of a **1** to **10** scale which proved to be more evenly distributed, though slight clustering around whole numbers still persisted. This confirms that when given a **1 to 100** scale, people tend to choose round numbers, but when the scale is reduced to **1 to 10**, the selection bias becomes less pronounced, resulting in a more natural distribution. This suggests that larger scales may unintentionally introduce cognitive biases, influencing how participants respond. The **mode** is **10**, meaning this value appears most frequently. The **first quartile (Q₁) is 10**, and the **third quartile (Q₃) is 40**, giving an **interquartile range (IQR) of 30**. A **standard deviation (δ) of 26.92** suggests significant variability in the data. Several **outliers** are present, particularly at the upper end, including **87, 89, 90, 92, 94, 95, 96, 97, 98, 99, and 100**, indicating the presence of extreme values beyond the typical range.
$$min = 1 \ \ \ \ max = 100 \ \ \ \ range = 99 \ \ \ \ mean = 31 \ \ \ \ median = 20 \ \ \ \ mode = 10 \ \ \ \ \delta = 26.91549067920283$$
$$q_1 = 10 \ \ \ \ q_3 = 40 \ \ \ \ IQR = 30 \ \ \ \ outliers = 87,89,90,92,94,95,96,97,98,99,100$$
![[Pasted image 20250329234321.png]]
![[Pasted image 20250329233855.png]]
![[Pasted image 20250329235128.png]]

### 3. Regression Line
In the context of this research, the **regression line** serves as a mathematical representation of the relationship between the independent variable (*x*) and the dependent variable (*y*). The line is determined by fitting a model to the data, minimizing the error between predicted and actual values, typically using metrics like **Sum of Squared Errors (SSE)**, **Mean Squared Error (MSE)**, and **Root Mean Squared Error (RMSE)**. 

The slope (*m*) of the regression line indicates the strength and direction of the relationship, while the intercept (*b*) represents the value of *y* when *x* equals zero. In this research, the regression line helps quantify the predictive power of the model, and the associated error metrics allow us to assess its accuracy.
$$m = \frac{n \sum x_i y_i - \sum x_i \sum y_i}{n \sum x_i^2 - (\sum x_i)^2} \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ b = \frac{\sum y_i - m \sum x_i}{n}$$

The formula for a regression line is:
$$\hat{y} = m*x + b$$
where ŷ is the predicted value, m is the slope and b is the interception.
##### Values 
$$mean = 31.1464039408867$$
$$median = 20$$
$$mode = 20$$
$$m\ (slope) = -0.4901493155851379$$
$$b\ (interception) = 36.329914042848148$$
The slope indicates a negative relationship between the predictor and response variables. If the hypothesis is that more experienced developers contribute to open source, and the slope of the regression line is negative, this would suggest that as experience increases, the desire to contribute to open projects decreases, which contradicts the original hypothesis.
![[Pasted image 20250327233648.png]]

For the display I used a bubble chart. It is similar to a scatter plot, however if multiple points coincident, then a single enlarged point is displayed. If I used a normal scatter plot those points would be invisible and the chart would be deceptive. Part of the reason so many points have the same values is the bias for numbers divisible by ten explained in the section about the *Y* variable.
### 4. Error Analysis

To evaluate the accuracy of the regression line, I used several error metrics that measure the difference between actual and predicted values. These metrics help assess the model's accuracy.

- Expected value - the result of applying the ***x*** value of a data point to the regression line. 
$$\hat{y}_i = m*x_i + b$$
##### Residuals and Sum of Squared Errors  
The residual for each data point is the difference between the actual and predicted values:
$$
\text{Residual} = y_i - \hat{y}_i
$$
To calculate it I used the ***y*** value of a data point and the result of feeding the ***x*** value to the regression line equation. A residual close to zero indicates a good prediction. To quantify the total error, I computed the Sum of Squared Errors (SSE):
$$SSE = \sum (y_i - \hat{y}_i)^2 \ \ \ \ \ \ \ \ SSE = \sum r_i^2$$
A lower SSE indicates a better fit of the model to the data.

##### Mean Squared Error
The Mean Squared Error (MSE) measures the average squared difference between actual and predicted values:
$$MSE = \frac{1}{n} \sum (y_i - \hat{y}_i)^2 \ \ \ \ \ \ \ \ \ MSE = \frac{SSE}{n}$$
Since it squares the residuals, MSE penalizes larger errors more than smaller ones. A lower MSE indicates a more accurate model.

##### Root Mean Squared Error
The Root Mean Squared Error (RMSE) is the square root of MSE:
$$RMSE = \sqrt{MSE}$$
Unlike MSE, RMSE is in the same units as the dependent variable, making it easier to interpret. It provides an intuitive measure of how much error we can expect on average.

##### Mean Absolute Error
The Mean Absolute Error (MAE) measures the average absolute difference between actual and predicted values:
$$
MAE = \frac{1}{n} \sum |y_i - \hat{y}_i|
$$

Unlike MSE and RMSE, MAE does not square the errors, making it less sensitive to outliers. A lower MAE indicates a better model fit.

##### Coefficient of Determination
The Coefficient of Determination or "R-squared" score measures how well the independent variable explains the variance in the dependent variable:
$$R^2 = 1 - \frac{\sum (y_i - \hat{y}_i)^2}{\sum (y_i - \bar{y})^2} \ \ \ \ \ \ \ \ \ R^2 = 1 - \frac{SSE}{\sum (y_i - \bar{y})^2}$$
where
$$\hat{y} \ \ \bar{y}$$
are accordingly the predicted value and the mean of the actual values.
If the score equals one, it indicates a perfect fit. The higher the score, the better the fit. It can not be higher than 1. 
$$R^2 = 1$$
If the score equals 0 then the model does not explain the variation.
$$R^2 = 0$$
If the score is negative that suggests the model performs worse than a horizontal line.
$$R^2 < 0$$
##### Values
$$SSE = 3495597.1887857199$$
$$MSE = 688.7876234060532$$
$$RMSE = 26.24476373309642$$
$$MAE = 20.340206244444475$$
$$R^2 = 0.024199359771126307$$
###### Interpretation of Error Metrics
The data reveals a notable discrepancy between *RMSE* and *MAE*, with the *RMSE* being significantly higher than *MAE*, which suggests the presence of outliers in the dataset. This large difference occurs because *RMSE* penalizes large errors more heavily due to the squaring of differences between actual and predicted values. The fact that *MAE* remains relatively stable indicates that while the majority of the data fits the model well, the few extreme values are disproportionately affecting the *RMSE*. Therefore, this difference between the two error metrics supports the hypothesis that outliers are present in the dataset, which is additionally proven by the high *SSE* and *MSE*.

A high *Coefficient of Determination* value suggests the model explains most of the variance in the data. In this case it is close to 0 (~0.02) which means that the variability in the dependent (response) variable is not explained by the independent (predictor) variables.



## Conclision
The analysis of regression metrics in this research provides insights into the relationship between developer experience and operating system preference. The regression model, represented by its slope and intercept, was expected to show a positive correlation if more experienced developers enjoy contributing to open source. However, the **negative slope** suggests the opposite trend—indicating that Linux preference decreases as experience increases, contradicting the initial hypothesis.

Further investigation into error metrics, particularly the difference between **RMSE** and **MAE**, suggests the presence of **outliers** that may be influencing the squared error measures. Since **MSE** and **SSE** penalize large deviations more heavily, substantial differences between RMSE and MAE indicate that some extreme values might be skewing the results. This raises the need for further data refinement, such as filtering potential outliers, reassessing the sampling method, or considering additional influencing factors like job roles, industry demands, or developer specialization.

Ultimately, while the current model does not support the hypothesis, the findings provide valuable direction for refining the research approach. Adjusting the dataset, testing alternative regression models, and incorporating additional variables may yield a clearer understanding of the hypothesis.

## References

- Statista - <https://www.statista.com/statistics/627312/worldwide-developer-population/pub >
- Stackoverflow's 2024 survey - <https://survey.stackoverflow.co/2024/>
