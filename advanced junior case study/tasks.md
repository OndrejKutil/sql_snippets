# Securities Trading & Portfolio Analysis Case Study

### Scenario

You are now an intermediate-level analyst at an investment firm. Your team maintains a database of client accounts, trades, security price history, and dividend payments. Each client (called an account in the data) can buy and sell various financial instruments (stocks, funds, or other securities). The dataset reflects real-world trading data from 1 January 2024 through 30 September 2025.

The tables in this case study mirror a typical trading data model:

- The `securities` table lists each tradable item with its code, name, sector, and currency.
- The `prices` table records daily closing prices for each security; it stores the timestamp (`price_date`) and the `closing_price`.
- Client `accounts` store details about investors (name, region, risk profile), while `trades` track buy/sell transactions (account, security, date, quantity, and price).
- The `dividends` table records dividend payments per share for some securities.

### Data Overview

Unzip `sql_case_study_advanced_data.zip` to obtain the following CSV files. Each file should be imported into your database as a table. A high-level description of each table is provided below:

| Table     | Description                                                                                                                                         | Key columns                                                                                                   |
|-----------|-----------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------|
| securities| List of tradable financial instruments. Each row contains a unique symbol, a descriptive name, its sector (e.g., Technology, Financial, Energy), and the currency used for quoting prices. | `security_id (PK)`, `symbol`, `name`, `sector`, `currency`                                                    |
| accounts  | Client accounts at the investment firm. Each account has a name, region, risk profile, and the date the account was opened.                         | `account_id (PK)`, `first_name`, `last_name`, `region`, `risk_profile`, `open_date`                           |
| prices    | Daily closing prices for each security. There is one row per security per day.                                                                      | `price_id (PK)`, `security_id (FK to securities)`, `price_date`, `closing_price`                              |
| trades    | Individual buy or sell transactions. Each trade records the account involved, the security traded, the trade date, the trade type (BUY or SELL), the quantity, and the execution price. | `trade_id (PK)`, `account_id (FK to accounts)`, `security_id (FK to securities)`, `trade_date`, `trade_type`, `quantity`, `price` |
| dividends | Dividend payments for securities. Each row records a dividend per share on a specific date for a security. Some securities pay no dividends.        | `dividend_id (PK)`, `security_id (FK to securities)`, `dividend_date`, `dividend_per_share`                   |

The dataset includes 10 securities, 20 accounts, daily price history (≈ 1.5 years), 300 trades, and 14 dividend events. Trade prices vary slightly from closing prices to simulate bid/ask spreads. Some securities pay dividends 1–3 times during the period.

### Analysis Tasks

These exercises require more advanced SQL features such as window functions, date logic, subqueries, and data manipulation. Unless otherwise specified, return only the columns requested and order your results logically. Comments and clear aliases are encouraged.

1) Positions as of 30 September 2025
  - Calculate the net position (shares held) for each account and security by summing quantities of BUY trades minus SELL trades up to and including `2025-09-30`.
  - Only include positions where the resulting quantity is not zero.
  - For each position, also compute the cost basis (weighted average purchase price).
  - Hint: use a CTE to aggregate buys and sells separately, then join.

2) Portfolio Value by Account
  - Using the positions from Task 1 and the closing prices on `2025-09-30`, compute the market value of each account’s portfolio.
  - Rank accounts by portfolio value and list the top 5 with their total value.
  - Include each account’s region and risk profile.

3) Monthly Portfolio Value in 2025
  - For every account and each month in 2025, compute the portfolio value on the last trading day of that month.
  - Steps:
    - Determine each account’s holdings up to the month-end date (sum of buys minus sells up to that date).
    - Join these holdings to the closing price on that month-end date.
    - Return a table with `account_id`, `month_end_date`, and `portfolio_value`.
  - Hint: use a date function to get the last day of each month and window functions to carry forward closing prices.

4) Security Metrics
  - For each security, calculate the daily return: `(closing_price / LAG(closing_price) - 1)` ordered by date.
  - Compute the 30-day moving average (simple) of `closing_price` and the 30-day moving volatility (standard deviation of daily returns) using a window frame of the last 30 observations (including current).
  - Return results for July 2025.
  - Required columns: `security_id`, `price_date`, `closing_price`, `daily_return`, `ma30`, `vol30`.

5) Dividend Income
  - For each account, calculate the total dividend income received from all securities.
  - A dividend is received only if the account holds the security on the dividend date (based on trades executed up to that date).
  - Dividend income is `dividend_per_share × shares_held_on_dividend_date`.
  - List the top 5 accounts by total dividend income and compute each account’s dividend yield, defined as `total_dividend_income / portfolio_value_on_dividend_date`.
  - For the yield, use the portfolio value immediately before the dividend is paid.

6) Sector Allocation
  - Determine the sector allocation of each account’s portfolio as of `2025-09-30`.
  - For each account and sector, compute the market value and the percentage of the account’s total portfolio value.
  - Identify accounts where a single sector accounts for more than 50% of the portfolio.
  - Return: `account_id`, `sector`, `value`, `percentage`, and a flag indicating whether this sector concentration exceeds 50%.

7) Security Total Return
  - For each security, compute the total return from 1 January 2024 to 30 September 2025, including price appreciation and dividends.
  - Formula: `(price_end - price_start + total_dividends) / price_start`.
  - Identify the best and worst performing securities.
  - Provide: `symbol`, `sector`, total return percentage, and total dividends paid.

8) Portfolio Turnover
  - For each account, compute the portfolio turnover ratio: `(sum of the absolute quantities of all trades during 2025) / (average net holdings during 2025)`.
  - Net holdings can be approximated by averaging the absolute positions at the start and end of the year.
  - Rank accounts by turnover ratio and discuss which accounts are the most active traders.

9) Data Modification (Sector Change)
  - On 1 January 2025, the security with symbol `MIX1` was reclassified into a new sector called `Mixed`.
  - Write an SQL statement to update the `sector` column in the `securities` table for this security.
  - After executing the update, run a query to verify that `MIX1` now has `sector = 'Mixed'`.

10) (Optional) Portfolio Sharpe Ratio
  - For a challenge, compute the monthly Sharpe ratio for each account in 2025.
  - First calculate monthly portfolio returns, then assume a constant risk-free rate of 0.5% per year (≈ 0.0417% per month).
  - Sharpe ratio: `(average monthly return – risk-free rate) / standard deviation of monthly returns`.
  - Return: `account_id` and its Sharpe ratio.

### Deliverables

- Data files: Import the contents of `sql_case_study_advanced_data.zip` into your Supabase database. The archive contains the five CSV files described above.
- SQL queries and results: Write SQL code to answer each question. For the update task, run the `UPDATE` statement and then a `SELECT` statement to confirm the change. Comment your code to explain your logic.

These tasks will strengthen your ability to work with financial time-series data, compute portfolio metrics, use window functions, and perform data modifications. They emulate typical analyses performed by quantitative analysts and portfolio managers.