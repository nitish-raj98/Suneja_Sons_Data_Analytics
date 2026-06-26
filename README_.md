# Suneja Sons Sales & Operations Analytics

## 📊 Complete Data Analytics Project

A **professional end-to-end data analytics project** for Suneja Sons Pvt. Ltd. (paper trading company). This project showcases the complete pipeline: Data Cleaning → MySQL Database → Advanced SQL Analysis → Interactive Power BI Dashboard.

**Developer:** Nitish Raj (Individual)  
**Status:** ✅ Complete & Production Ready  
**Email:** nnitishraj2016@gmail.com  
**GitHub:** github.com/nitish-raj98

---

## 📈 Project Snapshot

| Metric | Value |
|--------|-------|
| **Orders Analyzed** | 2,529 |
| **Total Quantity** | 30,440+ MT |
| **Top Customer** | Suneja Sons (638 orders) |
| **Completion Rate** | 69.56% |
| **Customers Tracked** | 27+ |
| **Quality Types** | 8+ varieties |
| **Avg Order Size** | 12.03 MT |

---

## 🔄 Complete Data Pipeline

### **Stage 1: Data Cleaning (Python/Pandas/Jupyter)**
✅ Cleaned raw CSV data with 2,529 orders  
✅ Standardized date formats (DD-MM-YYYY)  
✅ Removed duplicates & missing values  
✅ Unified mill codes (M & BCM standardized)  
✅ Cleaned column names & removed special characters  
**File:** `SS_DATA_PROJECT.ipynb`

### **Stage 2: MySQL Database**
✅ Created optimized MySQL schema  
✅ Imported 2,529 cleaned records  
✅ Database: `new_file.suneja_sons`  
✅ Added proper indexing for performance  
✅ Configured Safe Mode for data integrity  

### **Stage 3: SQL Analysis (6 Categories)**
✅ Customer Loyalty Analysis (ROW_NUMBER, CTE, HAVING)  
✅ Status Trend per Product (Window functions, percentages)  
✅ Quarter-over-Quarter Analysis (LAG, date functions)  
✅ Product Quality Analysis (Ranking, percentages)  
✅ Ranking & Comparison (Window functions, averages)  
✅ Status Tracking (Status progression, analysis)  
**File:** `SS_DATA_PROJECT.sql` (15+ advanced queries)

### **Stage 4: Power BI Dashboard**
✅ 4 KPI Cards (summary metrics)  
✅ 5 Interactive Visualizations  
✅ 2 Smart Filters (Quality & Status)  
✅ Professional formatting & design  
✅ Dynamic filtering across all charts  
**File:** `SS_DATA_PROJECT.pbix`

---

## 📊 Power BI Dashboard Features

### **KPI Cards (4)**
```
Average Qty Per Order: 12.03 MT
Top Customer: Suneja Sons
Total Orders: 2,529
Total Quantity: 30,440 MT
```

### **Interactive Visualizations (5)**

**1. Top Customers (Bar Chart)**
- Suneja Sons: 6,782.80 MT
- GLS ELOPAK: 6,144.00 MT
- DIS PRINTER: 1,720.60 MT
- Top 10 customers analyzed

**2. Quality Distribution (Pie Chart)**
- 8+ quality types analyzed
- Market share percentage breakdown
- Color-coded for easy identification

**3. Status Distribution (Pie Chart)**
- Complete: 69.56% (21.17K MT) ✅
- Pending: 30.44% (9.26K MT) ⏳

**4. Orders Trend (Line Chart)**
- Monthly quantity trends
- Seasonal pattern: Peak in July-August
- Shows ordering patterns over time

**5. Customer Rankings (Data Table)**
- Top 15+ customers detailed
- Metrics: Total Orders, Total Quantity, Avg Qty/Order
- Summary totals: 1,345 orders, 23,593.80 MT

### **Smart Filters**
- **Quality Slicer:** Filter by paper type
- **Status Slicer:** Toggle Complete/Pending
- **Dynamic Updates:** All charts respond instantly

---

## 💡 Key Findings

### Customer Insights
- **Suneja Sons dominates:** 638 orders (10.63 MT avg)
- **GLS ELOPAK is #2:** 37 orders (166.05 MT avg)
- **27+ customers tracked** for comprehensive analysis
- **Concentration risk:** Top customer = significant volume

### Order Status Analysis
- **69.56% completion rate** (strong performance)
- **30.44% pending orders** (improvement opportunity)
- **Acceleration needed** on pending order fulfillment

### Seasonal Trends
- **Peak Season:** July-August (4K+ MT orders)
- **Monthly Average:** 200+ orders per month
- **Pattern:** Clear seasonality in ordering

### Quality Mix
- **MULTILAYER LIQUID PACKAGING:** Top quality (50.03%)
- **HIZINE:** 5.22% share
- **COATED BOARD:** 7.16% share
- **8+ varieties:** Well-distributed portfolio

---

## 🛠️ Technologies & Tools

| Layer | Technology | Details |
|-------|-----------|---------|
| **Data Cleaning** | Python 3.x, Pandas | Jupyter Notebook |
| **Development** | Jupyter | Interactive environment |
| **Database** | MySQL 8.0+ | Production-grade |
| **Analysis** | MySQL Workbench | Advanced SQL queries |
| **Visualization** | Power BI Desktop | Interactive dashboard |
| **Version Control** | Git/GitHub | Repository management |

---

## 📂 Project Files Included

```
Suneja_Sons_Data_Analytics/
├── README.md                           (This file)
├── Suneja_Sons_Project_Summary.docx    (Full project report)
├── SS_DATA_PROJECT.ipynb               (Data cleaning pipeline)
├── SS_DATA_PROJECT.sql                 (SQL analysis queries)
├── SS_DATA_PROJECT.pbix                (Power BI dashboard)
├── DATABASE.csv                        (Cleaned dataset)
└── Dashboard_SSProject.png             (Dashboard screenshot)
```

---

## 🔍 SQL Analysis Techniques

### Window Functions Used
- `ROW_NUMBER()` - Customer and status ranking
- `LAG()` - Quarter-over-quarter comparisons
- `AVG() OVER()` - Comparisons from average
- `SUM() OVER()` - Aggregate calculations
- `DENSE_RANK()` - Dense ranking without gaps

### Query Patterns
- **CTEs (Common Table Expressions)** - Complex multi-step queries
- **PARTITION BY** - Group-wise calculations
- **HAVING Clauses** - Filter grouped results
- **Date Functions** - Monthly trend analysis

### SQL Examples

**Customer Loyalty Analysis:**
```sql
WITH customer_analyze AS (
  SELECT 
    Customer,
    COUNT(*) AS Total_Orders,
    SUM(QTY_MT) AS Total_Quantity,
    AVG(QTY_MT) AS Avg_Quantity_Per_Order,
    ROW_NUMBER() OVER (ORDER BY SUM(QTY_MT) DESC) AS ROW_NO
  FROM suneja_sons
  GROUP BY Customer
  HAVING COUNT(*) > 5
)
SELECT * FROM customer_analyze;
```

**Status Distribution with Percentages:**
```sql
SELECT
  QUALITY,
  STATUS,
  COUNT(*) AS Order_Count,
  ROUND((COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY QUALITY)) * 100, 2) AS Percentage
FROM suneja_sons
GROUP BY QUALITY, STATUS;
```

---

## 📊 Dashboard Usage Guide

### How to View the Dashboard
1. **Install Power BI Desktop** (if not already installed)
2. **Open file:** `SS_DATA_PROJECT.pbix`
3. **Interact with:**
   - Quality filter to select specific paper types
   - Status filter to toggle Complete/Pending
   - Charts update dynamically based on selections

### What Each Visualization Shows
- **Bar Chart:** Which customers order most quantity
- **Quality Pie Chart:** Distribution across paper types
- **Status Pie Chart:** Order completion vs pending
- **Line Chart:** Ordering trends over months
- **Data Table:** Detailed customer metrics

---

## 💼 Skills Demonstrated

✅ **Data Engineering**
- ETL pipeline design & execution
- Data cleaning & validation with Pandas
- Database schema design & optimization

✅ **SQL Expertise**
- Advanced query writing (15+ queries)
- Window functions & CTEs
- Query optimization with indexing
- Complex aggregations & group operations

✅ **Business Intelligence**
- Dashboard design principles
- KPI definition & tracking
- Interactive visualization
- Data storytelling & insights

✅ **Professional Development**
- End-to-end project delivery
- Complete documentation
- Clean, commented code
- Portfolio-ready work

---

## 🎯 Business Recommendations

1. **Accelerate Pending Orders**
   - 30% of orders are pending
   - Implement faster processing workflows
   - Set targets for completion rate improvement

2. **Leverage Peak Season**
   - July-August are peak months
   - Plan inventory & staffing accordingly
   - Prepare marketing campaigns in advance

3. **Strengthen Top Customer Relationship**
   - Suneja Sons drives significant volume
   - Consider loyalty programs & incentives
   - Regular strategic reviews needed

4. **Diversify Customer Base**
   - Reduce dependency on single customer
   - Develop targeted growth strategies
   - Focus on mid-tier customer development

5. **Optimize Quality Mix**
   - Monitor demand patterns
   - Adjust portfolio based on trends
   - Consider expanding high-demand qualities

---

## 🚀 Getting Started

### To View Dashboard
- Install Microsoft Power BI Desktop (free)
- Open `SS_DATA_PROJECT.pbix`
- Interact with filters and visualizations

### To Review SQL Queries
- Install MySQL Workbench (free)
- Open `SS_DATA_PROJECT.sql`
- Review or run queries against MySQL

### To See Data Cleaning
- Install Jupyter Notebook
- Open `SS_DATA_PROJECT.ipynb`
- Review Pandas data transformation steps

---

## ✨ What Makes This Project Special

✓ **Complete Pipeline:** Raw data → Database → Analysis → Dashboard  
✓ **Real Business Data:** 2,529 actual orders analyzed  
✓ **Advanced SQL:** Window functions, CTEs, complex queries  
✓ **Professional Dashboard:** Interactive, filtered, 5 visualizations  
✓ **Well Documented:** Code comments, SQL explanations, full reports  
✓ **Portfolio Ready:** Clean code, professional formatting, clear insights  

---

## 📋 Project Completion Status

| Task | Status |
|------|--------|
| Data Collection & Cleaning | ✅ Complete |
| MySQL Database Setup | ✅ Complete |
| SQL Analysis (6 categories) | ✅ Complete |
| Power BI Dashboard | ✅ Complete |
| Documentation & Reports | ✅ Complete |
| **Overall Project** | **✅ PRODUCTION READY** |

---

## 👤 About Developer

**Nitish Raj**
- Senior Data Analyst at Suneja Sons Pvt. Ltd.
- Background: English (IGNOU)
- Skills: Python, SQL, MySQL, Power BI, Excel, Data Analysis
- Portfolio: End-to-end analytics projects
- Email: nnitishraj2016@gmail.com
- GitHub: github.com/nitish-raj98

---

## 📞 Contact & Connect

- **Email:** nnitishraj2016@gmail.com
- **GitHub:** github.com/nitish-raj98
- **Project:** Suneja Sons Data Analytics

---

## 📄 License

This project is open source and available for portfolio, educational, and professional purposes.

---

**Project Status: ✅ COMPLETE & READY FOR PORTFOLIO**

*Built with Python, MySQL, Power BI, and Git. A professional-grade end-to-end data analytics solution.*

---

*Last Updated: June 2026*  
*Version: 1.0 (Production Ready)*
