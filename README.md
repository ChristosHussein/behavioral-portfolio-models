Quantitative Walk-Forward Portfolio Optimization Engine
A MATLAB-based quantitative backtesting engine using Walk-Forward Optimization (Rolling Window) to test four distinct portfolio allocation strategies across a 500-stock universe.

This engine is specifically built to eliminate Look-Ahead Bias and In-Sample Overfitting by simulating 1,000 blind Monte Carlo trials, forcing the algorithms to trade strictly on historical data without future sight.

Core Features
Walk-Forward Optimization: Algorithms calculate weights using a 6-month historical lookback window, then hold those weights for a 3-month forward window before rebalancing.

Bias-Adjusted Universe: The 500-stock pool is intentionally populated with both modern mega-cap winners and legacy/stagnant companies to reflect a realistic market.

Pre-Fetch Data Caching: Bypasses free-tier API throttling by downloading and caching the entire 10-year price history into RAM before execution.

Advanced Metrics: Automatically generates a dashboard calculating Annualized Volatility, Sharpe Ratios, and the Ulcer Index (Drawdown risk).

The Strategies Tested
Markowitz (Mean-Variance): Maximizes return while strictly minimizing the covariance/variance of the portfolio.

Exponential (CARA): Uses Constant Absolute Risk Aversion to aggressively penalize the portfolio when it drops below a benchmark.

Cumulative Prospect Theory (CPT): Models behavioral psychology, penalizing losses roughly 2.25x harder than equivalent gains to mimic human fear.

Logarithmic: Aims purely for maximum geometric compounding over time, accepting high daily volatility.

Results & Eliminating Bias
A major focus of this project is demonstrating the danger of backtesting biases. When algorithms are allowed to optimize over a full 10-year dataset (In-Sample), they achieve an impossible, overfitted ~900% return.

By applying the Walk-Forward Rolling Window, this engine compresses those theoretical returns down to a realistic Out-Of-Sample (OOS) performance of ~250% - 300%, closely fighting the S&P 500 benchmark.

Additionally, the CPT algorithm demonstrates that by trading based on human fear, the portfolio heavily anchors to defensive industrials (e.g., CHRW, JNJ, CAT), resulting in massive opportunity cost during bull markets.

Installation & Usage
Requirements: MATLAB (R2020a or newer) and the Optimization Toolbox (required for fmincon).

Execution: Open MegaSimulation.m and run the script.

Note: The pre-fetch cache takes ~2 minutes. Running 1,000 rolling-window trials performs roughly 160,000 non-linear optimizations and may take 15–45 minutes depending on your CPU.

License
This project is licensed under the MIT License. See the LICENSE file for details.
