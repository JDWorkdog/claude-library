# Python Notebook Project

## Environment
- Python 3.11+
- Jupyter notebooks
- pandas, numpy, matplotlib, seaborn

## Setup
```bash
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
jupyter lab
```

## Structure
```
├── notebooks/        # Jupyter notebooks
├── data/            # Raw and processed data
├── src/             # Reusable Python modules
├── outputs/         # Generated reports/figures
└── requirements.txt
```

## Conventions
- Clear notebook sections with markdown headers
- Reproducible analysis (set random seeds)
- Document assumptions and limitations
- Save intermediate results for large computations
