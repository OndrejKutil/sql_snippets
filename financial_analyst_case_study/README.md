# Financial Analyst Case Study

## Table Schemas

### revenues

| Column           | Type   | Description           |
|------------------|--------|-----------------------|
| date             | DATE   | Date of revenue       |
| region           | TEXT   | Region name           |
| product_category | TEXT   | Product category      |
| client_segment   | TEXT   | Client segment        |
| revenue_czk      | NUMBER | Revenue in CZK        |

### expenses

| Column     | Type   | Description           |
|------------|--------|-----------------------|
| date       | DATE   | Date of expense       |
| cost_type  | TEXT   | Type of cost          |
| department | TEXT   | Department name       |
| amount_czk | NUMBER | Expense amount in CZK |
