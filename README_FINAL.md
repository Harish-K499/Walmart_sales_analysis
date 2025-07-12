# 🛒 Walmart Sales Data Analysis 📊

This project analyzes Walmart transactional data using Python (Pandas), SQL, and Jupyter Notebooks.

## 🚀 Features
- Data cleaning and transformation with Python (pandas)
- SQL queries to solve real-world business questions
- Exploratory data analysis in Jupyter Notebook
- Insightful KPIs like top-performing branches, busiest hours, and profit analysis

## 📂 Project Structure
```
project/
├── data/                      # Cleaned CSV dataset
├── notebooks/
│   └── prj.ipynb              # Main analysis notebook
├── sql/
│   └── Walmartdata.sql        # SQL queries for business questions
├── requirements.txt           # Python dependencies
└── README.md                  # Project overview
```

## 🧠 Business Questions Solved (via SQL)

Here are some key SQL problems addressed in the project:

1. **Most common payment method by branch**
2. **Highest rated category per branch**
3. **Busiest day for each branch**
4. **Profit by category**  
5. **Year-over-year revenue drop by branch**
6. **Sales shift classification (morning, afternoon, night)**

### 🧾 Sample SQL Query

```sql
-- Identify 5 branches with highest revenue drop from 2022 to 2023
WITH last_year_rev AS (
    SELECT branch, EXTRACT(YEAR FROM date) AS year, SUM(total_revenue) AS revenue
    FROM walmart
    WHERE EXTRACT(YEAR FROM date) = 2022
    GROUP BY branch, year
),
current_year_rev AS (
    SELECT branch, EXTRACT(YEAR FROM date) AS year, SUM(total_revenue) AS revenue
    FROM walmart
    WHERE EXTRACT(YEAR FROM date) = 2023
    GROUP BY branch, year
)
SELECT 
    cr.branch,
    cr.revenue AS current_year_rev,
    lr.revenue AS last_year_rev,
    ROUND((cr.revenue - lr.revenue) / lr.revenue * 100, 2) AS revenue_change_ratio
FROM current_year_rev cr
JOIN last_year_rev lr ON cr.branch = lr.branch
ORDER BY revenue_change_ratio ASC
LIMIT 5;
```

👉 Full query set: [`sql/Walmartdata.sql`](sql/Walmartdata.sql)

---

## 📊 Python Notebook Analysis

The notebook includes:
- Data cleaning (`unit_price`, `date` parsing, null checks)
- EDA: sales by time, day, branch, and category
- Visualizations using Matplotlib and Seaborn

📓 Open the notebook: [`notebooks/prj.ipynb`](notebooks/prj.ipynb)

---

## 🛠 Tech Stack

- Python (Pandas, Matplotlib, Seaborn)
- MySQL (via SQLAlchemy for integration)
- Jupyter Notebook

---

## 🔧 How to Run

```bash
pip install -r requirements.txt
jupyter notebook notebooks/prj.ipynb
```

---

## 📄 License

This project is licensed under the MIT License.
