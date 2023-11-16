# Diabetes Prediction – Deep Leaning Model and Optimization
This is a project contributed by 3 contributors while each of the contributor responsible for each different deep learning models.

The mian objective of this project is to build and evaluate an optimal deep learning model (hyperparameter tuning) for the diabetes prediction problem.

## Implementation
Based on the literature review in the past recent 5 years, the contributors decide to build the following deep learning models for the prediction of diabetes detection:
1. ANN
2. DNN
3. One-Dimension(1D) CNN - build & tuning by the developer

## Result
The table below show the optimal deep learning model built after hyperparameter tuning
| Model                | Accuracy | Precision | Recall | F1-Score |
|----------------------|----------|-----------|--------|----------|
| ANN Model            | 0.8712   | 0.88      | 0.87   | 0.87     |
| DNN Model            | 0.8703   | 0.88      | 0.87   | 0.87     |
| 1D-CNN Model         | **0.8901**   | **0.90**      | **0.89**   | **0.89**     |

## Discussion
According to the results collected by the team, the best model out of the three different models built was a 1D convolutional neural network model. 
The 1D convolutional neural network model was the best among the three different models, probably because the 1D convolutional neural network uses filters to convolve the input data, 
allowing it to capture local patterns and changes in the diabetes dataset. 
This approach is particularly effective when there are significant short-term patterns in the data that can aid diabetes prediction. 
Since the filters are able to recognize certain local features, 1D-CNN may have advantages over fully-linked layers in ANN or DNN. 
Apart from this, another reason could be that hierarchical features can be learned through convolutional layers in 1D CNN. 
Lower layers can learn simple features such as edges or trends, while higher layers can learn more complex combinations of these features. 
This hierarchical learning can help models understand the structure of diabetes data and contribute to more accurate diabetes predictions.
