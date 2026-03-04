% =========================================================================
% ULTIMATE MONTE CARLO ENGINE & POST-PROCESSING SUITE (V4.0)
% 500-Stock Pool | 1000 Trials | Rolling Window Walk-Forward | Caching
% =========================================================================
clear; clc; close all;

% --- 1. SETUP PARAMETERS (The "No Look-Ahead Bias" 500 Pool) ---
candidatePool = unique({ ...
    'AAPL','MSFT','GOOGL','AMZN','META','TSLA','BRK-B','JNJ','JPM','XOM', ...
    'V','WMT','PG','CVX','UNH','PFE','HD','INTC','T','VZ','KO','C','WFC', ...
    'BAC','PEP','MRK','CSCO','DIS','ORCL','CMCSA','BA','IBM','MCD','GE', ...
    'PM','MDT','ABT','MMM','AMGN','HON','UNP','GILD','BMY','MO','TXN', ...
    'QCOM','CVS','SLB','UPS','LMT','CAT','GS','MS','AXP','BLK','SCHW', ...
    'USB','PNC','TFC','BK','STT','COF','DFS','SYF','PRU','MET','AIG', ...
    'TRV','ALL','PGR','CB','CME','ICE','MCO','SPGI','MDLZ','KHC','GIS', ...
    'SYY','K','HSY','CHD','CLX','EL','CL','KMB','STZ','TAP','HAL','BKR', ...
    'EOG','COP','OXY','PXD','MPC','PSX','VLO','WMB','KMI','NEE','DUK', ...
    'SO','D','AEP','EXC','SRE','XEL','ED','WEC','PEG','AWK','NEM','FCX', ...
    'NUE','VMC','MLM','DOW','DD','ECL','SHW','APD','AMT','PLD','CCI', ...
    'SPG','PSA','O','WELL','VTR','AVB','EQR','DLR','EQIX','SBAC','WY', ...
    'ARE','BXP','HST','LVS','MAR','HLT','CCL','RCL','EXPE','BKNG','EBAY', ...
    'F','GM','ORLY','AZO','TSCO','GPC','TGT','LOW','SBUX','NKE','VFC', ...
    'TJX','ROST','DG','DLTR','WBA','RAD','KR','BBY','M','JWN','KSS','GPS', ...
    'HPQ','HPE','XRX','WDC','STX','NTAP','AKAM','JNPR','GLW','FFIV', ...
    'MSI','HPE','DXC','CTSH','IT','FIS','FISV','JKHY','BR','PAYX','ADP', ...
    'GPN','FLT','WU','TRMB','PTC','CDNS','SNPS','ANSS','ADBE','CRM', ...
    'INTU','WDAY','NOW','PANW','FTNT','NLOK','CHKP','FFIV','FSLR','ENPH', ...
    'SEDG','RUN','SPWR','RIG','DO','NE','TDW','HP','FTI','NOV','OII', ...
    'MRO','APA','DVN','HES','FANG','CLR','MUSA','MUR','CPE','MTDR', ...
    'PDCE','SM','LPI','RRC','AR','EQT','SWN','COG','CNX','CHK','GNRC', ...
    'PWR','J','SNA','SWK','TT','CARR','OTIS','IR','CMI','PCAR','URI', ...
    'R','RSG','WM','CHRW','EXPD','JBHT','ODFL','LUV','DAL','UAL','AAL', ...
    'ALK','JBLU','SAVE','HA','RCL','NCLH','CCL','PEN','MGM','WYNN', ...
    'CZR','PENN','DKNG','CHDN','BYD','IGT','SCI','CSV','HZO','MTH', ...
    'LEN','DHI','PHM','TOL','KBH','NVR','MDC','TMHC','GRBK','TPH', ...
    'PII','THO','WGO','BC','YETI','PTON','FIT','GPRO','SIRI','SPOT', ...
    'LYV','WMG','EDR','WWE','TKO','MANU','BATRA','FWONA','CNK','MCS', ...
    'AMC','IMAX','RDI','DISCA','DISCK','FOXA','FOX','NWSA','NWS','PARA', ...
    'WBD','CMCSA','CHTR','CABO','SJR','BCE','TU','TEL','GLW','PH','ETN', ...
    'EMR','ROK','AME','DOV','XYL','IEX','PNR','AOS','NDSN','CGNX','FLS', ...
    'ITT','HI','WTS','RBC','CFR','CMA','ZION','FHN','SNV','EWBC','PBCT', ...
    'BXS','TCBI','CUBI','HOPE','WABC','UMPQ','COLB','BANR','GBCI','TOWN', ...
    'CVBF','FNB','ONB','INDB','UMBF','IBOC','CBSH','BOKF','CULL','FRME', ...
    'WTFC','WIN','CTL','LUMN','FTR','GCI','LEE','NYT','TRCO','Meredith', ...
    'DNB','EFX','TRU','FICO','NLSN','JLL','CBRE','CWK','HFF','RMAX', ...
    'EXR','CUBE','LSI','NSC','CSX','KSU','CP','CNI','UNP','JBHT','KNX', ...
    'WERN','ARCB','SAIA','YELL','XPO','RXO','GPO','HUBG','CHRW','EXPD', ...
    'DSGX','SPSC','MAN','KFY','RHI','ASGN','UPWK','FVRR','ZIP','PAYC', ...
    'PCTY','CDAY','NSP','TNET','TRINET','HELE','NWL','CLX','REVG','HOG', ...
    'THO','WGO','BC','PII','YETI','FOXF','LVS','MGM','WYNN','CZR','PENN', ...
    'BYD','CHDN','RCL','NCLH','CCL','MAR','HLT','H','CHH','WH','IHG', ...
    'YUM','MCD','SBUX','CMG','DPZ','PZZA','WEN','QSR','JACK','TXRH', ...
    'DRI','BLMN','EAT','CAKE','DENN','DIN','SHAK','WING','PLAY','RUSH', ...
    'AAP','AZO','ORLY','GPC','TSCO','LKQ','MNRO','VLE','WMT','TGT','COST', ...
    'BJ','PRGO','HLF','USNA','MED','NHTSA','MCK','CAH','ABC','CNC','HUM', ...
    'MOH','UNH','ELV','CI','CVS','WBA','RAD','GILD','AMGN','BIIB','VRTX', ...
    'REGN','INCY','EXEL','ALXN','SGEN','MRNA','BNTX','NVAX','PFE','MRK', ...
    'JNJ','LLY','ABBV','BMY','ABT','ZTS','IDXX','PAH','ELAN','TMO','DHR', ...
    'A','WAT','PKI','MTD','BRKR','CRL','IQV','PRHS','SYK','MDT','BSX', ...
    'EW','ZBH','SNN','NUVA','GMED','HCA','THC','CYH','UHS','SEM','ACHC', ...
    'EHC','LH','DGX','Q','OPK','NEO','MYGN','EXAS','GH','NVTA','NTRA'});

benchmarkTicker = '^GSPC'; 
range = '10y'; 
numTrials = 1000; 
numAssets = 6;
options = weboptions('HeaderFields', {'User-Agent', 'Mozilla/5.0'}, 'Timeout', 60);

% --- 2. DATA ACQUISITION (BENCHMARK) ---
disp('1. Fetching 10-year Benchmark...');
try
    raw_sp = webread(sprintf('https://query1.finance.yahoo.com/v8/finance/chart/%s?interval=1d&range=%s', benchmarkTicker, range), options);
catch ME
    error('Fatal Error: Failed to fetch Benchmark. Yahoo Finance may be blocking the request. %s', ME.message);
end

rawPrices = raw_sp.chart.result(1).indicators.quote(1).close;
validIdx = ~isnan(rawPrices);
spPrices = rawPrices(validIdx);
spReturns = diff(spPrices(:)) ./ spPrices(1:end-1);
marketRisk = std(spReturns) * sqrt(252) * 100;
dynamicRef = spReturns + (0.05 / 252); 
rawDates = raw_sp.chart.result(1).timestamp;
validDates = datetime(rawDates(validIdx), 'ConvertFrom', 'posixtime');
dates = validDates(2:end); 

% --- 3. PRE-FETCH & CACHE ALL DATA ---
disp('2. Pre-fetching and caching all stock data to prevent API throttling...');
priceCache = containers.Map('KeyType', 'char', 'ValueType', 'any');
validCandidates = {};

for i = 1:length(candidatePool)
    ticker = candidatePool{i};
    if mod(i, 20) == 0, fprintf('   Caching stock %d of %d...\n', i, length(candidatePool)); end
    try
        data = webread(sprintf('https://query1.finance.yahoo.com/v8/finance/chart/%s?interval=1d&range=%s', ticker, range), options);
        p = data.chart.result(1).indicators.quote(1).close; 
        p = p(~isnan(p));
        
        % Only keep stocks with at least ~7 years of trading history (1800 days)
        if length(p) >= 1800
            priceCache(ticker) = p(:);
            validCandidates{end+1} = ticker;
        end
        
        pause(0.1); % Be polite to Yahoo's servers
    catch
        fprintf('   [Throttled/Missing/Dead Ticker] Skipping %s\n', ticker);
        pause(1.0); % Back off if rejected
    end
end

candidatePool = validCandidates; 
disp(['Successfully cached ', num2str(length(candidatePool)), ' valid stocks.']);

% --- 4. TRACKING INITIALIZATION ---
% Initialized with NaN so missing historical data doesn't average as 0.00% return
trialResults = struct('Mark', NaN(length(spReturns), numTrials), ...
                      'Exp', NaN(length(spReturns), numTrials), ...
                      'CPT', NaN(length(spReturns), numTrials), ...
                      'Log', NaN(length(spReturns), numTrials));
                  
risks = struct('Mark', NaN(numTrials, 1), 'Exp', NaN(numTrials, 1), ...
               'CPT', NaN(numTrials, 1), 'Log', NaN(numTrials, 1));
trialCovariances = NaN(numTrials, 1); 
           
mvpWeights = containers.Map('KeyType', 'char', 'ValueType', 'double');
mvpCounts = containers.Map('KeyType', 'char', 'ValueType', 'double');

% --- 5. MONTE CARLO TRIALS (1000 ROLLING WINDOW OUT-OF-SAMPLE) ---
lookback = 126;  % 6 months (126 trading days) of historical data to optimize
rebal = 63;      % 3 months (63 trading days) to hold before rebalancing

disp(['3. Starting ', num2str(numTrials), ' Walk-Forward Trials. This will take a while...']);
t = 1;

while t <= numTrials
    if mod(t, 10) == 0, fprintf('   Progress: %d/%d Trials...\n', t, numTrials); end
    
    randIdx = randperm(length(candidatePool), numAssets);
    currentTickers = candidatePool(randIdx);
    
    priceData = cell(1, numAssets);
    currentMinLen = length(spReturns) + 1;
    
    % Pull directly from memory cache
    for i = 1:numAssets
        p = priceCache(currentTickers{i});
        priceData{i} = p;
        currentMinLen = min(currentMinLen, length(p));
    end
    
    % Get the full matrix of returns for these 6 stocks
    R_mat = zeros(currentMinLen-1, numAssets);
    for i = 1:numAssets
        p_slice = priceData{i}(end-currentMinLen+1:end);
        R_mat(:, i) = diff(p_slice) ./ p_slice(1:end-1);
    end
    
    % Only proceed if we have enough data to form at least one lookback window
    if size(R_mat, 1) <= lookback, continue; end
    
    % Pre-allocate Out-of-Sample (OOS) tracking arrays for this trial
    oos_len = size(R_mat, 1) - lookback;
    oos_Mark = NaN(oos_len, 1); oos_Exp = NaN(oos_len, 1);
    oos_CPT = NaN(oos_len, 1); oos_Log = NaN(oos_len, 1);
    
    % Set up optimizer constraints once
    Aeq = ones(1, numAssets); beq = 1; lb = 0.05*ones(1,numAssets); ub = 0.8*ones(1,numAssets);
    w0 = ones(1, numAssets)/numAssets;
    opt = optimoptions('fmincon', 'Display', 'off', 'Algorithm', 'sqp');
    
    validTrial = true;
    
    % ==== THE ROLLING WINDOW (WALK-FORWARD) LOOP ====
    for step = lookback : rebal : size(R_mat, 1)-1
        
        % Calculate forward window boundary
        forwardEnd = min(step + rebal, size(R_mat, 1));
        forwardLen = forwardEnd - step;
        
        % 1. Slice In-Sample Historical Data (The "Past")
        R_in = R_mat(step-lookback+1 : step, :);
        ref_in = dynamicRef(end - size(R_mat,1) + step - lookback + 1 : end - size(R_mat,1) + step);
        sp_in = spReturns(end - size(R_mat,1) + step - lookback + 1 : end - size(R_mat,1) + step);
        
        try
            % 2. Optimize Target Weights based strictly on the PAST
            wMark = fmincon(@(w) (w*cov(R_in)*w'*252) - 1.0*(mean(R_in)*w'*252), w0, [], [], Aeq, beq, lb, ub, [], opt);
            wExp = fmincon(@(w) mean(exp(-5 * (R_in*w' - ref_in))), w0, [], [], Aeq, beq, lb, ub, [], opt);
            wCPT = fmincon(@(w) calcCPTAlpha(w, R_in, ref_in), w0, [], [], Aeq, beq, lb, ub, [], opt);
            wLog = fmincon(@(w) -mean(log(max(1e-4, 1 + R_in*w' - sp_in))), w0, [], [], Aeq, beq, lb, ub, [], opt);
        catch
            validTrial = false; break; % If math fails on a weird window, scrap the trial
        end
        
        % 3. Apply Target Weights to Out-Of-Sample Data (The "Future")
        R_out = R_mat(step+1 : forwardEnd, :);
        
        idxStart = step - lookback + 1;
        idxEnd = step - lookback + forwardLen;
        
        oos_Mark(idxStart:idxEnd) = R_out * wMark';
        oos_Exp(idxStart:idxEnd) = R_out * wExp';
        oos_CPT(idxStart:idxEnd) = R_out * wCPT';
        oos_Log(idxStart:idxEnd) = R_out * wLog';
        
        % Track CPT MVP on the final roll
        if forwardEnd == size(R_mat, 1)
            for i = 1:numAssets
                tick = currentTickers{i};
                if isKey(mvpWeights, tick)
                    mvpWeights(tick) = mvpWeights(tick) + wCPT(i);
                    mvpCounts(tick) = mvpCounts(tick) + 1;
                else
                    mvpWeights(tick) = wCPT(i);
                    mvpCounts(tick) = 1;
                end
            end
        end
    end
    
    if ~validTrial, continue; end
    
    % Store the Out-of-Sample results into the global tracking matrices
    trialResults.Mark(end-oos_len+1:end, t) = oos_Mark;
    trialResults.Exp(end-oos_len+1:end, t) = oos_Exp;
    trialResults.CPT(end-oos_len+1:end, t) = oos_CPT;
    trialResults.Log(end-oos_len+1:end, t) = oos_Log;
    
    risks.Mark(t) = std(oos_Mark, 'omitnan') * sqrt(252);
    risks.Exp(t) = std(oos_Exp, 'omitnan') * sqrt(252);
    risks.CPT(t) = std(oos_CPT, 'omitnan') * sqrt(252);
    risks.Log(t) = std(oos_Log, 'omitnan') * sqrt(252);
    
    trialCovariances(t) = mean(mean(cov(R_mat) * 252)); 
    t = t + 1;
end

% --- 6. AGGREGATION ---
disp('4. Trials Complete. Running Post-Processing...');
avgRetMark = mean(trialResults.Mark, 2, 'omitnan');
avgRetExp = mean(trialResults.Exp, 2, 'omitnan');
avgRetCPT = mean(trialResults.CPT, 2, 'omitnan');
avgRetLog = mean(trialResults.Log, 2, 'omitnan');

avgRetMark(isnan(avgRetMark)) = 0;
avgRetExp(isnan(avgRetExp)) = 0;
avgRetCPT(isnan(avgRetCPT)) = 0;
avgRetLog(isnan(avgRetLog)) = 0;

% --- 7. VISUALIZATION (PERFORMANCE & MVP) ---
figure('Name', 'Cumulative Performance (Walk-Forward Out-Of-Sample)', 'Position', [50, 400, 800, 400]);
hold on;
plot(dates, (cumprod(1+spReturns)-1)*100, 'm', 'LineWidth', 1.2, 'DisplayName', 'S&P 500');
plot(dates, (cumprod(1+avgRetMark)-1)*100, 'Color', [1 0.5 0], 'LineWidth', 1.5, 'DisplayName', 'Markowitz');
plot(dates, (cumprod(1+avgRetExp)-1)*100, 'b', 'LineWidth', 1.5, 'DisplayName', 'Exponential');
plot(dates, (cumprod(1+avgRetCPT)-1)*100, 'r', 'LineWidth', 2, 'DisplayName', 'CPT');
plot(dates, (cumprod(1+avgRetLog)-1)*100, 'g', 'LineWidth', 1.5, 'DisplayName', 'Logarithmic');
title('Averaged 10-Year OOS Return (1000 Trials)'); ylabel('Return (%)'); grid on; legend('Location', 'northwest');

mvpKeys = keys(mvpWeights);
mvpAvgWeights = zeros(length(mvpKeys), 1);
for i = 1:length(mvpKeys)
    mvpAvgWeights(i) = mvpWeights(mvpKeys{i}) / mvpCounts(mvpKeys{i});
end
[sortedWeights, sIdx] = sort(mvpAvgWeights, 'descend');
numToShow = min(10, length(sIdx));
topWeightsPlot = flip(sortedWeights(1:numToShow) * 100); 
topTickersPlot = flip(mvpKeys(sIdx(1:numToShow)));

figure('Name', 'MVP Stock Utilization - Top 10', 'Position', [150, 150, 900, 500]);
hold on;
colorMap = lines(numToShow); 
for i = 1:numToShow
    bar(i, topWeightsPlot(i), 'FaceColor', colorMap(i,:), 'DisplayName', topTickersPlot{i});
end
set(gca, 'XTick', 1:numToShow);
set(gca, 'XTickLabel', topTickersPlot);
ylabel('Average Portfolio Weight (%)'); xlabel('Stock Ticker');
title(['Top ', num2str(numToShow), ' MVP Stocks (Highest Avg OOS Utilization)']); grid on;
legend('Location', 'eastoutside');
for i = 1:numToShow
    text(i, topWeightsPlot(i), sprintf('%0.2f%%', topWeightsPlot(i)), ...
        'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'FontWeight', 'bold');
end
hold off;

% --- 8. RISK BENCHMARKING ---
avgRiskMark = mean(risks.Mark, 'omitnan') * 100;
avgRiskExp = mean(risks.Exp, 'omitnan') * 100;
avgRiskCPT = mean(risks.CPT, 'omitnan') * 100;
avgRiskLog = mean(risks.Log, 'omitnan') * 100;

figure('Name', 'Risk Benchmarking: Portfolio vs Market', 'Position', [100, 100, 600, 450]);
riskValues = [marketRisk, avgRiskMark, avgRiskExp, avgRiskCPT, avgRiskLog];
b = bar(riskValues, 'FaceColor', 'flat');
b.CData = [1 0 1; 1 0.5 0; 0 0 1; 1 0 0; 0 1 0]; 
set(gca, 'xticklabel', {'Market', 'Markowitz', 'Exponential', 'CPT', 'Logarithmic'});
ylabel('Annualized Volatility (%)'); title('Average Risk Comparison (1000 Trials)'); grid on;

% --- 9. DASHBOARDS (BASIC & ADVANCED) ---
disp(' '); disp('================= RISK & PERFORMANCE DASHBOARD =================');
fprintf('STRATEGY           | ANN. RETURN | AVG. RISK (VOL) | RISK DELTA\n');
fprintf('----------------------------------------------------------------\n');
fmt1 = '%-18s | %10.2f%% | %14.2f%% | %9.2f%%\n';
fprintf(fmt1, 'S&P 500 (Market)', mean(spReturns)*25200, marketRisk, 0.00);
fprintf(fmt1, 'Markowitz (M-V)', mean(avgRetMark)*25200, avgRiskMark, avgRiskMark - marketRisk);
fprintf(fmt1, 'Exponential', mean(avgRetExp)*25200, avgRiskExp, avgRiskExp - marketRisk);
fprintf(fmt1, 'CPT (Behavioral)', mean(avgRetCPT)*25200, avgRiskCPT, avgRiskCPT - marketRisk);
fprintf(fmt1, 'Logarithmic', mean(avgRetLog)*25200, avgRiskLog, avgRiskLog - marketRisk);

rf = 0.02 / 252; 
targetDaily = (mean(spReturns) + (0.05/252)); 
calcSharpe = @(r) (mean(r) - rf) / std(r) * sqrt(252);
calcSuccess = @(r) sum(r > targetDaily) / length(r) * 100;

disp(' '); disp('==================== ADVANCED METRIC DASHBOARD ====================');
fprintf('%-18s | %-12s | %-12s | %-12s\n', 'STRATEGY', 'SHARPE RATIO', 'SUCCESS RATE', 'ULCER INDEX');
fprintf('------------------------------------------------------------------\n');
fmt2 = '%-18s | %12.2f | %11.1f%% | %12.2f\n';
fprintf(fmt2, 'S&P 500 (Absolute)', calcSharpe(spReturns), sum(spReturns>0)/length(spReturns)*100, calcUlcer(spReturns));
fprintf(fmt2, 'Markowitz (M-V)', calcSharpe(avgRetMark), calcSuccess(avgRetMark), calcUlcer(avgRetMark));
fprintf(fmt2, 'Exponential', calcSharpe(avgRetExp), calcSuccess(avgExp), calcUlcer(avgRetExp));
fprintf(fmt2, 'CPT (Behavioral)', calcSharpe(avgRetCPT), calcSuccess(avgRetCPT), calcUlcer(avgRetCPT));
fprintf(fmt2, 'Logarithmic', calcSharpe(avgRetLog), calcSuccess(avgRetLog), calcUlcer(avgRetLog));
disp('==================================================================');

% --- 10. SENSITIVITY ANALYSIS (Snapshot Example from last trial) ---
disp('Running Lambda Sensitivity Analysis on the final Elite 6 Portfolio...');
lambda_vec = 1.0:0.25:5.0; 
results_ret = zeros(size(lambda_vec));
results_risk = zeros(size(lambda_vec));
for i = 1:length(lambda_vec)
    w0 = ones(1, numAssets)/numAssets;
    opt = optimoptions('fmincon', 'Display', 'off', 'Algorithm', 'sqp');
    w_opt = fmincon(@(w) calcCPT_Variable(w, R_mat, dynamicRef(end-size(R_mat,1)+1:end), lambda_vec(i)), w0, [], [], Aeq, beq, lb, ub, [], opt);
    port_ret = R_mat * w_opt';
    results_ret(i) = mean(port_ret) * 252 * 100;
    results_risk(i) = std(port_ret) * sqrt(252) * 100;
end

figure('Name', 'CPT Sensitivity: The Cost of Fear', 'Position', [100, 100, 900, 400]);
subplot(1,2,1);
plot(lambda_vec, results_ret, 'r-o', 'LineWidth', 2);
xlabel('Loss Aversion (\lambda)'); ylabel('Ann. Expected Return (%)');
title('Expected Return vs. Loss Aversion'); grid on;
subplot(1,2,2);
plot(lambda_vec, results_risk, 'b-o', 'LineWidth', 2);
xlabel('Loss Aversion (\lambda)'); ylabel('Ann. Portfolio Risk (%)');
title('Portfolio Risk vs. Loss Aversion'); grid on;

% --- 11. MATHEMATICAL FRAMEWORK & CONSTANTS REPORT ---
disp(' ');
disp('================ INVESTOR UTILITY & CONSTANTS LOG ================');
disp('1. MARKOWITZ (Mean-Variance) [The Rational Optimizer]');
disp('   Goal: Maximize Return while Minimizing Variance');
disp('   Function: U(w) = A_risk * (w^T * mu) - (w^T * Sigma * w)');
fprintf('   Constants: A_risk = 1.0  (Risk Aversion Penalty)\n\n');

disp('2. EXPONENTIAL (Constant Absolute Risk Aversion) [The Hedger]');
disp('   Goal: Heavily penalize large deviations below the target.');
disp('   Function: U(w) = -mean(exp(-A * (R_port - R_target)))');
fprintf('   Constants: A = 5.0  (Curvature / Severity of Penalty)\n\n');

disp('3. CPT (Behavioral) [The Human Investor]');
disp('   Goal: Maximize probability-weighted value, penalizing losses heavily.');
disp('   Value Function: v(x) = x^alpha (Gains), v(x) = -lambda * (-x)^beta (Losses)');
disp('   Weighting Function: w(p) = exp(-(-ln(p))^delta) [Prelec]');
fprintf('   Constants: alpha=0.88, beta=0.88, lambda=2.25, delta=0.65\n\n');

disp('4. LOGARITHMIC [The Aggressive Compounder]');
disp('   Goal: Maximize long-term geometric compound growth rate.');
disp('   Function: U(w) = mean(ln(max(1e-4, 1 + R_port - R_target)))');
fprintf('   Constants: None (Parameter-free pure growth model)\n\n');

disp('--- UNDERLYING ASSET DYNAMICS ---');
fprintf('Overall Average Pairwise Covariance (Annualized): %.6f\n', mean(trialCovariances, 'omitnan'));
disp('==================================================================');

% --- 12. AUTOSAVE ---
save('MegaSimulation_AutoSave.mat');
disp('SUCCESS: Workflow complete and Workspace automatically saved!');

% =========================================================================
% LOCAL FUNCTIONS
% =========================================================================
function negUtil = calcCPTAlpha(w, R_mat, ref)
    alpha = 0.88; beta = 0.88; lambda = 2.25; delta = 0.65;
    pR = (R_mat * w')'; pR = pR(:); ref = ref(:);
    excessR = pR - ref; [sortedEx, ~] = sort(excessR); T = length(sortedEx);
    i_vec = (0:T)'/T; i_vec(1) = 1e-10; w_cum = exp(-(-log(i_vec)).^delta);
    pi_weights = diff(w_cum(:)); U = zeros(T, 1);
    U(sortedEx >= 0) = sortedEx(sortedEx >= 0).^alpha;
    U(sortedEx < 0) = -lambda .* (abs(sortedEx(sortedEx < 0)).^beta);
    val = sum(pi_weights .* U);
    if isnan(val) || isinf(val), negUtil = 1e10; else, negUtil = -val; end
end

function ui = calcUlcer(r)
    cumRet = cumprod(1+r);
    maxReached = cummax(cumRet);
    drawdown = (cumRet ./ maxReached) - 1;
    ui = sqrt(mean(drawdown.^2)) * 100;
end

function negUtil = calcCPT_Variable(w, R_mat, ref, lam)
    alpha = 0.88; beta = 0.88; delta = 0.65; 
    pR = (R_mat * w')'; pR = pR(:); ref = ref(:);
    excessR = pR - ref; [sortedEx, ~] = sort(excessR); T = length(sortedEx);
    i_vec = (0:T)'/T; i_vec(1) = 1e-10; 
    w_cum = np_prelec(i_vec, delta); 
    pi_weights = diff(w_cum(:)); U = zeros(T, 1);
    U(sortedEx >= 0) = sortedEx(sortedEx >= 0).^alpha;
    U(sortedEx < 0) = -lam .* (abs(sortedEx(sortedEx < 0)).^beta); 
    negUtil = -sum(pi_weights .* U);
end

function wc = np_prelec(p, d)
    wc = exp(-(-log(p)).^d); 
end