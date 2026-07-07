# Insurance Premium Prediction

A machine learning project that predicts a customer's **insurance premium category** (e.g., Low / Medium / High) from demographic, lifestyle, and financial attributes, served through a FastAPI backend for real-time predictions.

## Overview

Instead of predicting a raw premium amount directly, this project engineers a set of risk-driven features and trains a classifier to place each customer into a premium category. This makes the model's output more interpretable for downstream business use (e.g., pricing tiers) while still capturing the key drivers of insurance risk: body composition, age, lifestyle habits, location, income, and occupation.

## Features

- **Feature engineering pipeline** that derives:
  - `bmi` — calculated from weight and height
  - `age_group` — bucketed into `young`, `adult`, `middle_aged`, `senior`
  - `lifestyle_risk` — derived from smoking status and BMI (`low`, `medium`, `high`)
  - `city_tier` — maps raw city names to Tier 1 / Tier 2 / Tier 3 classifications
- **scikit-learn pipeline** combining `ColumnTransformer` (One-Hot Encoding for categorical features) with a `RandomForestClassifier`
- **Model evaluation** via train/test split, accuracy score, and 15-fold cross-validation
- **Model persistence** using `pickle` for easy reuse
- **FastAPI service** to expose the trained model as a REST API for real-time premium category predictions

## Tech Stack

- **Language:** Python
- **ML/Data:** pandas, NumPy, scikit-learn
- **Model serving:** FastAPI
- **Model persistence:** pickle

## Project Structure

```
insurance-premium-prediction/
├── fastapi_ml_model.ipynb   # Data prep, feature engineering, training & evaluation
├── model.pkl                # Serialized trained pipeline
├── main.py                  # FastAPI app exposing the /predict endpoint
├── requirements.txt
└── README.md
```

*(Adjust file names above to match your actual repo layout.)*

## Input Features

| Feature | Type | Description |
|---|---|---|
| `bmi` | numeric | Body Mass Index, computed from weight and height |
| `age_group` | categorical | `young`, `adult`, `middle_aged`, `senior` |
| `lifestyle_risk` | categorical | `low`, `medium`, `high`, based on smoking + BMI |
| `city_tier` | categorical | `1`, `2`, or `3`, based on city of residence |
| `income_lpa` | numeric | Annual income in lakhs per annum |
| `occupation` | categorical | Customer's occupation |

**Target:** `insurance_premium_category`

## Getting Started

### 1. Clone the repo

```bash
git clone https://github.com/[your-username]/insurance-premium-prediction.git
cd insurance-premium-prediction
```

### 2. Install dependencies

```bash
pip install -r requirements.txt
```

### 3. Train the model (optional — a pre-trained `model.pkl` is included)

Run through `fastapi_ml_model.ipynb` to reproduce feature engineering, training, and evaluation, or to retrain on your own dataset.

### 4. Run the API

```bash
uvicorn main:app --reload
```

The API will be available at `http://127.0.0.1:8000`, with interactive docs at `http://127.0.0.1:8000/docs`.

### 5. Example request

```bash
curl -X POST "http://127.0.0.1:8000/predict" \
  -H "Content-Type: application/json" \
  -d '{
    "bmi": 24.5,
    "age_group": "adult",
    "lifestyle_risk": "medium",
    "city_tier": 1,
    "income_lpa": 12,
    "occupation": "salaried"
  }'
```

## Model Performance

| Metric | Score |
|---|---|
| Test Accuracy | 90% |


*(Fill in with your actual results from the notebook.)*

## Roadmap

- [ ] Hyperparameter tuning (GridSearch/Optuna)
- [ ] Model explainability (SHAP values for feature contribution)
- [ ] Dockerize the FastAPI service
- [ ] Add authentication and request logging to the API
- [ ] CI/CD pipeline for automated retraining and deployment

## Contributing

Contributions are welcome! Please open an issue to discuss significant changes before submitting a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
