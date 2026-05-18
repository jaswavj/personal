<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*"%>
<jsp:useBean id="op1" class="billing.billingBean" />
<jsp:useBean id="prod" class="product.productBean" />
<%
///////////////////  Sales  /////////////////
double thisSale  = op1.getThisMonthPhSale();
double lastSale  = op1.getLastMonthPhSale();
double saleMargin = thisSale - lastSale;
double saleMarginPercent = 0;
if (lastSale != 0) {
    saleMarginPercent = (saleMargin / lastSale) * 100;
}

///////////////////  Today's Sales  /////////////////
double todaySales    = op1.getTodaySales();
int    todayBillCount = op1.getTodayBillCount();

///////////////////  Date Ranges  /////////////////
java.util.Calendar cal = java.util.Calendar.getInstance();
cal.set(java.util.Calendar.DAY_OF_MONTH, 1);
String thisMonthStart = new java.text.SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
cal.set(java.util.Calendar.DAY_OF_MONTH, cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH));
String thisMonthEnd = new java.text.SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());

cal.add(java.util.Calendar.MONTH, -1);
cal.set(java.util.Calendar.DAY_OF_MONTH, 1);
String lastMonthStart = new java.text.SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
cal.set(java.util.Calendar.DAY_OF_MONTH, cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH));
String lastMonthEnd = new java.text.SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());

///////////////////  Profit  /////////////////
Vector thisMonthProfitData = op1.getProfitAnalysisReport(thisMonthStart, thisMonthEnd);
double thisProfit = 0.0;
for (int i = 0; i < thisMonthProfitData.size(); i++) {
    Vector row = (Vector) thisMonthProfitData.elementAt(i);
    double totalCost  = Double.parseDouble(row.elementAt(4).toString());
    double saleTotal  = Double.parseDouble(row.elementAt(5).toString());
    thisProfit += (saleTotal - totalCost);
}

Vector lastMonthProfitData = op1.getProfitAnalysisReport(lastMonthStart, lastMonthEnd);
double lastProfit = 0.0;
for (int i = 0; i < lastMonthProfitData.size(); i++) {
    Vector row = (Vector) lastMonthProfitData.elementAt(i);
    double totalCost  = Double.parseDouble(row.elementAt(4).toString());
    double saleTotal  = Double.parseDouble(row.elementAt(5).toString());
    lastProfit += (saleTotal - totalCost);
}

double profitMarginPercent = 0;
if (lastProfit != 0) profitMarginPercent = ((thisProfit - lastProfit) / lastProfit) * 100;

///////////////////  Expenses  /////////////////
double thisExpense = 0.0;
try {
    Vector thisMonthExpenses = prod.getExpenseReport(thisMonthStart, thisMonthEnd, 0);
    if (thisMonthExpenses != null) {
        for (int i = 0; i < thisMonthExpenses.size(); i++) {
            Vector row = (Vector) thisMonthExpenses.get(i);
            if (row.size() > 4) thisExpense += Double.parseDouble(row.get(4).toString());
        }
    }
} catch (Exception e) { System.err.println("Error loading this month expenses: " + e.getMessage()); }

double lastExpense = 0.0;
try {
    Vector lastMonthExpenses = prod.getExpenseReport(lastMonthStart, lastMonthEnd, 0);
    if (lastMonthExpenses != null) {
        for (int i = 0; i < lastMonthExpenses.size(); i++) {
            Vector row = (Vector) lastMonthExpenses.get(i);
            if (row.size() > 4) lastExpense += Double.parseDouble(row.get(4).toString());
        }
    }
} catch (Exception e) { System.err.println("Error loading last month expenses: " + e.getMessage()); }

double expenseMarginPercent = 0;
if (lastExpense != 0) expenseMarginPercent = ((thisExpense - lastExpense) / lastExpense) * 100;

double netProfit = thisProfit - thisExpense;

///////////////////  Today Date  /////////////////
java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd-MMM-yyyy");
String todayDate = sdf.format(new java.util.Date());

/////////////////////  Daily Sales Chart (16 days)  //////////////////
Vector vecSales = op1.getSalesReportCharts();
StringBuilder dailyLabels    = new StringBuilder();
StringBuilder dailySalesData = new StringBuilder();
for (int i = 0; i < vecSales.size(); i++) {
    Vector row   = (Vector) vecSales.elementAt(i);
    String date  = row.elementAt(0).toString();
    String total = row.elementAt(1).toString();
    dailyLabels.append('"').append(date).append('"');
    dailySalesData.append(total.isEmpty() || total.equals("0") ? "0" : total);
    if (i < vecSales.size() - 1) { dailyLabels.append(", "); dailySalesData.append(", "); }
}

/////////////////////  Daily Expense Chart (16 days)  //////////////////
StringBuilder dailyExpenseData = new StringBuilder();
try {
    Vector vecExpense = prod.getExpenseReportCharts();
    for (int i = 0; i < vecExpense.size(); i++) {
        Vector row   = (Vector) vecExpense.elementAt(i);
        String total = row.elementAt(1).toString();
        dailyExpenseData.append(total.isEmpty() || total.equals("0") ? "0" : total);
        if (i < vecExpense.size() - 1) dailyExpenseData.append(", ");
    }
} catch (Exception e) {
    for (int i = 0; i < vecSales.size(); i++) {
        dailyExpenseData.append("0");
        if (i < vecSales.size() - 1) dailyExpenseData.append(", ");
    }
}

/////////////////////  Monthly Sales Chart (12 months)  //////////////////
Vector vecMonthlySales  = op1.getMonthlySalesCharts();
StringBuilder monthlyLabels    = new StringBuilder();
StringBuilder monthlySalesData = new StringBuilder();
for (int i = 0; i < vecMonthlySales.size(); i++) {
    Vector row   = (Vector) vecMonthlySales.elementAt(i);
    String month = row.elementAt(0).toString();
    String total = row.elementAt(1).toString();
    monthlyLabels.append('"').append(month).append('"');
    monthlySalesData.append(total.isEmpty() || total.equals("0") ? "0" : total);
    if (i < vecMonthlySales.size() - 1) { monthlyLabels.append(", "); monthlySalesData.append(", "); }
}

/////////////////////  Monthly Expense Chart (12 months)  //////////////////
StringBuilder monthlyExpenseData = new StringBuilder();
try {
    Vector vecMonthlyExpense = prod.getMonthlyExpenseCharts();
    for (int i = 0; i < vecMonthlyExpense.size(); i++) {
        Vector row   = (Vector) vecMonthlyExpense.elementAt(i);
        String total = row.elementAt(1).toString();
        monthlyExpenseData.append(total.isEmpty() || total.equals("0") ? "0" : total);
        if (i < vecMonthlyExpense.size() - 1) monthlyExpenseData.append(", ");
    }
} catch (Exception e) {
    for (int i = 0; i < vecMonthlySales.size(); i++) {
        monthlyExpenseData.append("0");
        if (i < vecMonthlySales.size() - 1) monthlyExpenseData.append(", ");
    }
}

/////////////////////  Top Customers & Outstanding  //////////////////
Vector<Vector> topCustomers         = op1.getTopCustomers();
Vector<Vector> outstandingCustomers = op1.getOutstandingCustomers();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <%@ include file="/assets/common/head.jsp" %>
    <style>
        body { background: #f0f2f5; }

        .metric-card {
            border: none;
            border-radius: 14px;
            box-shadow: 0 2px 8px rgba(0,0,0,.07);
            transition: transform .2s, box-shadow .2s;
            overflow: hidden;
            background: #fff;
        }
        .metric-card:hover { transform: translateY(-4px); box-shadow: 0 8px 20px rgba(0,0,0,.12); }
        .metric-card .card-body { padding: .9rem 1rem; position: relative; }
        .metric-label {
            font-size: .68rem; font-weight: 700;
            text-transform: uppercase; letter-spacing: .05em;
            color: #6c757d; margin-bottom: .15rem;
        }
        .metric-value { font-size: 1.25rem; font-weight: 800; color: #1a1a2e; margin-bottom: .25rem; line-height: 1.2; }
        .metric-sub   { font-size: .7rem; color: #adb5bd; }
        .metric-badge { font-size: .68rem; font-weight: 700; padding: .2em .55em; border-radius: 20px; }
        .badge-up      { background: #d1fae5; color: #065f46; }
        .badge-down    { background: #fee2e2; color: #991b1b; }
        .badge-neutral { background: #e0e7ff; color: #3730a3; }
        .card-bg-icon  { position: absolute; right: 14px; top: 50%; transform: translateY(-50%); font-size: 2.6rem; opacity: .08; }

        .chart-panel { background: #fff; border-radius: 14px; padding: 1.1rem 1.25rem; box-shadow: 0 2px 8px rgba(0,0,0,.07); }
        .panel-title    { font-size: .9rem; font-weight: 700; color: #1a1a2e; margin-bottom: .1rem; }
        .panel-subtitle { font-size: .72rem; color: #adb5bd; }
        .chart-wrap    { position: relative; height: 250px; }
        .chart-wrap-sm { position: relative; height: 200px; }
        .chart-wrap-lg { position: relative; height: 290px; }

        .data-panel { background: #fff; border-radius: 14px; padding: 1.1rem 1.25rem; box-shadow: 0 2px 8px rgba(0,0,0,.07); }
        .data-panel table thead th { font-size: .72rem; text-transform: uppercase; letter-spacing: .04em; color: #6c757d; border-bottom: 2px solid #f0f2f5; background: transparent; }
        .data-panel table tbody td { font-size: .82rem; vertical-align: middle; }
        .rank-badge { width: 22px; height: 22px; border-radius: 50%; background: #e0e7ff; color: #3730a3; font-size: .7rem; font-weight: 700; display: inline-flex; align-items: center; justify-content: center; }

        .section-header { font-size: .78rem; font-weight: 700; text-transform: uppercase; letter-spacing: .06em; color: #9ca3af; padding: .5rem 0 .25rem; }

        .accent-blue   { border-left: 4px solid #3b82f6 !important; }
        .accent-indigo { border-left: 4px solid #6366f1 !important; }
        .accent-violet { border-left: 4px solid #8b5cf6 !important; }
        .accent-teal   { border-left: 4px solid #14b8a6 !important; }
        .accent-amber  { border-left: 4px solid #f59e0b !important; }
        .accent-red    { border-left: 4px solid #ef4444 !important; }
        .accent-green  { border-left: 4px solid #22c55e !important; }
        .accent-orange { border-left: 4px solid #f97316 !important; }
    </style>
</head>
<body>
    <%@ include file="/assets/navbar/navbar.jsp" %>
    <div class="container-fluid py-3 px-4">

        <!-- KPI CARDS -->
        <p class="section-header mb-2">Overview</p>
        <div class="row g-3 mb-3">

            <div class="col-xl-3 col-lg-4 col-md-6">
                <div class="card metric-card accent-red h-100">
                    <div class="card-body">
                        <p class="metric-label">Today's Sales</p>
                        <p class="metric-sub mb-1"><%= todayDate %></p>
                        <p class="metric-value">&#8377; <%= String.format("%,.0f", todaySales) %></p>
                        <span class="metric-badge badge-neutral"><i class="fas fa-receipt me-1"></i><%= todayBillCount %> Bills</span>
                        <i class="fas fa-calendar-day card-bg-icon text-danger"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-lg-4 col-md-6">
                <div class="card metric-card accent-blue h-100">
                    <div class="card-body">
                        <p class="metric-label">This Month Sales</p>
                        <p class="metric-value">&#8377; <%= String.format("%,.0f", thisSale) %></p>
                        <span class="metric-badge <%= saleMarginPercent >= 0 ? "badge-up" : "badge-down" %>">
                            <i class="fas <%= saleMarginPercent >= 0 ? "fa-arrow-up" : "fa-arrow-down" %> me-1"></i>
                            <%= String.format("%.1f", Math.abs(saleMarginPercent)) %>% vs last month
                        </span>
                        <i class="fas fa-chart-line card-bg-icon text-primary"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-lg-4 col-md-6">
                <div class="card metric-card accent-indigo h-100">
                    <div class="card-body">
                        <p class="metric-label">Last Month Sales</p>
                        <p class="metric-value">&#8377; <%= String.format("%,.0f", lastSale) %></p>
                        <span class="metric-badge badge-neutral">Previous period</span>
                        <i class="fas fa-history card-bg-icon" style="color:#6366f1;"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-lg-4 col-md-6">
                <div class="card metric-card accent-orange h-100">
                    <div class="card-body">
                        <p class="metric-label">This Month Expense</p>
                        <p class="metric-value">&#8377; <%= String.format("%,.0f", thisExpense) %></p>
                        <span class="metric-badge <%= expenseMarginPercent >= 0 ? "badge-down" : "badge-up" %>">
                            <i class="fas <%= expenseMarginPercent >= 0 ? "fa-arrow-up" : "fa-arrow-down" %> me-1"></i>
                            <%= String.format("%.1f", Math.abs(expenseMarginPercent)) %>% vs last month
                        </span>
                        <i class="fas fa-file-invoice card-bg-icon text-warning"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-lg-4 col-md-6">
                <div class="card metric-card accent-amber h-100">
                    <div class="card-body">
                        <p class="metric-label">Last Month Expense</p>
                        <p class="metric-value">&#8377; <%= String.format("%,.0f", lastExpense) %></p>
                        <span class="metric-badge badge-neutral">Previous period</span>
                        <i class="fas fa-receipt card-bg-icon" style="color:#f59e0b;"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-lg-4 col-md-6">
                <div class="card metric-card accent-teal h-100">
                    <div class="card-body">
                        <p class="metric-label">Gross Profit</p>
                        <p class="metric-value">&#8377; <%= String.format("%,.0f", thisProfit) %></p>
                        <span class="metric-badge <%= profitMarginPercent >= 0 ? "badge-up" : "badge-down" %>">
                            <i class="fas <%= profitMarginPercent >= 0 ? "fa-arrow-up" : "fa-arrow-down" %> me-1"></i>
                            <%= String.format("%.1f", Math.abs(profitMarginPercent)) %>% vs last month
                        </span>
                        <i class="fas fa-chart-pie card-bg-icon" style="color:#14b8a6;"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-lg-4 col-md-6">
                <div class="card metric-card <%= netProfit >= 0 ? "accent-green" : "accent-red" %> h-100">
                    <div class="card-body">
                        <p class="metric-label">Net Profit (After Expense)</p>
                        <p class="metric-value <%= netProfit >= 0 ? "text-success" : "text-danger" %>">
                            &#8377; <%= String.format("%,.0f", netProfit) %>
                        </p>
                        <span class="metric-badge <%= netProfit >= 0 ? "badge-up" : "badge-down" %>">Gross Profit &minus; Expense</span>
                        <i class="fas fa-coins card-bg-icon <%= netProfit >= 0 ? "text-success" : "text-danger" %>"></i>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-lg-4 col-md-6">
                <div class="card metric-card accent-violet h-100">
                    <div class="card-body">
                        <p class="metric-label">Expense Ratio</p>
                        <p class="metric-value">
                            <%= thisSale > 0 ? String.format("%.1f", (thisExpense / thisSale) * 100) : "0.0" %>%
                        </p>
                        <span class="metric-badge badge-neutral">Expense as % of Sales</span>
                        <i class="fas fa-percentage card-bg-icon" style="color:#8b5cf6;"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- DAILY CHARTS -->
        <p class="section-header mb-2">Daily Trend &mdash; Last 16 Days</p>
        <div class="row g-3 mb-3">
            <div class="col-lg-8">
                <div class="chart-panel h-100">
                    <p class="panel-title">Sales &amp; Expense Overview</p>
                    <p class="panel-subtitle mb-3">Day-by-day breakdown for the last 16 days</p>
                    <div class="chart-wrap"><canvas id="dailyComboChart"></canvas></div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="chart-panel h-100 d-flex flex-column">
                    <p class="panel-title">This Month Split</p>
                    <p class="panel-subtitle mb-3">Sales vs Expense distribution</p>
                    <div class="chart-wrap flex-grow-1"><canvas id="splitDonut"></canvas></div>
                    <div class="d-flex justify-content-around mt-3">
                        <div class="text-center">
                            <p class="mb-0 fw-bold" style="color:#3b82f6;">&#8377; <%= String.format("%,.0f", thisSale) %></p>
                            <p class="metric-sub">Sales</p>
                        </div>
                        <div class="text-center">
                            <p class="mb-0 fw-bold" style="color:#f97316;">&#8377; <%= String.format("%,.0f", thisExpense) %></p>
                            <p class="metric-sub">Expense</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-3 mb-3">
            <div class="col-md-6">
                <div class="chart-panel">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div><p class="panel-title">Daily Sales Trend</p><p class="panel-subtitle">Last 16 days</p></div>
                        <button id="btnDlDailySales" class="btn btn-sm btn-outline-primary"><i class="fas fa-download me-1"></i>Save</button>
                    </div>
                    <div class="chart-wrap-sm"><canvas id="dailySalesBar"></canvas></div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="chart-panel">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div><p class="panel-title">Daily Expense Trend</p><p class="panel-subtitle">Last 16 days</p></div>
                        <button id="btnDlDailyExpense" class="btn btn-sm btn-outline-warning"><i class="fas fa-download me-1"></i>Save</button>
                    </div>
                    <div class="chart-wrap-sm"><canvas id="dailyExpenseBar"></canvas></div>
                </div>
            </div>
        </div>

        <!-- 12-MONTH CHART -->
        <p class="section-header mb-2">Monthly Trend &mdash; Last 12 Months</p>
        <div class="row g-3 mb-3">
            <div class="col-12">
                <div class="chart-panel">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div>
                            <p class="panel-title">Monthly Sales &amp; Expense</p>
                            <p class="panel-subtitle">12-month comparison view</p>
                        </div>
                        <button id="btnDlMonthly" class="btn btn-sm btn-outline-secondary"><i class="fas fa-download me-1"></i>Save</button>
                    </div>
                    <div class="chart-wrap-lg"><canvas id="monthlyChart"></canvas></div>
                </div>
            </div>
        </div>

        <!-- CUSTOMER TABLES -->
        <p class="section-header mb-2">Customer Insights</p>
        <div class="row g-3 mb-4">
            <div class="col-lg-6">
                <div class="data-panel h-100">
                    <p class="panel-title mb-3"><i class="fas fa-users me-2" style="color:#3b82f6;"></i>Top Customers &mdash; This Month</p>
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead><tr><th>#</th><th>Customer</th><th class="text-end">Sales</th><th class="text-center">Bills</th></tr></thead>
                            <tbody>
                                <% if (topCustomers.size() == 0) { %>
                                    <tr><td colspan="4" class="text-center text-muted py-3">No data available</td></tr>
                                <% } else { for (int i = 0; i < topCustomers.size(); i++) {
                                    Vector row = topCustomers.get(i);
                                    String name   = (String) row.get(0);
                                    double sales  = (Double) row.get(1);
                                    int billCount = (Integer) row.get(2); %>
                                <tr>
                                    <td><span class="rank-badge"><%= i + 1 %></span></td>
                                    <td><strong><%= name %></strong></td>
                                    <td class="text-end fw-bold" style="color:#3b82f6;">&#8377; <%= String.format("%,.2f", sales) %></td>
                                    <td class="text-center"><span class="badge bg-light text-dark border"><%= billCount %></span></td>
                                </tr>
                                <% } } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="data-panel h-100">
                    <p class="panel-title mb-3"><i class="fas fa-exclamation-circle me-2" style="color:#f59e0b;"></i>Top Outstanding Customers</p>
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead><tr><th>#</th><th>Customer</th><th class="text-end">Outstanding</th></tr></thead>
                            <tbody>
                                <% if (outstandingCustomers.size() == 0) { %>
                                    <tr><td colspan="3" class="text-center text-muted py-3">No outstanding balances</td></tr>
                                <% } else {
                                    double totalPending = 0;
                                    for (int i = 0; i < outstandingCustomers.size(); i++) {
                                        Vector row     = outstandingCustomers.get(i);
                                        String name    = (String) row.get(0);
                                        double pending = (Double) row.get(2);
                                        totalPending  += pending; %>
                                <tr>
                                    <td><span class="rank-badge" style="background:#fff7ed;color:#c2410c;"><%= i + 1 %></span></td>
                                    <td><strong><%= name %></strong></td>
                                    <td class="text-end fw-bold text-warning">&#8377; <%= String.format("%,.2f", pending) %></td>
                                </tr>
                                <% } %>
                            </tbody>
                            <tfoot>
                                <tr class="table-light">
                                    <th colspan="2" class="text-end">Total Outstanding:</th>
                                    <th class="text-end text-danger">&#8377; <%= String.format("%,.2f", totalPending) %></th>
                                </tr>
                            </tfoot>
                            <% } %>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <script>
    const dailyLabels       = [<%= dailyLabels.toString() %>];
    const dailySalesArr     = [<%= dailySalesData.toString() %>];
    const dailyExpenseArr   = [<%= dailyExpenseData.toString() %>];
    const monthlyLabels     = [<%= monthlyLabels.toString() %>];
    const monthlySalesArr   = [<%= monthlySalesData.toString() %>];
    const monthlyExpenseArr = [<%= monthlyExpenseData.toString() %>];

    const rupeeTooltip = {
        mode: 'index', intersect: false,
        backgroundColor: 'rgba(15,23,42,.88)',
        padding: 10, cornerRadius: 8,
        callbacks: {
            label: ctx => ' ' + ctx.dataset.label + ': \u20B9' +
                parseFloat(ctx.parsed.y).toLocaleString('en-IN', {minimumFractionDigits: 0})
        }
    };
    const yScale = {
        beginAtZero: true,
        grid: { color: '#f0f2f5', borderDash: [3,4] },
        ticks: { callback: v => '\u20B9' + Number(v).toLocaleString('en-IN') }
    };
    const xScale = { grid: { display: false } };

    // 1. Daily Combined Line
    new Chart(document.getElementById('dailyComboChart'), {
        type: 'line',
        data: {
            labels: dailyLabels,
            datasets: [
                {
                    label: 'Sales',
                    data: dailySalesArr,
                    borderColor: '#3b82f6',
                    backgroundColor: 'rgba(59,130,246,.12)',
                    borderWidth: 2.5,
                    fill: true,
                    tension: 0.4,
                    pointRadius: 0,
                    pointHoverRadius: 5
                },
                {
                    label: 'Expense',
                    data: dailyExpenseArr,
                    borderColor: '#f97316',
                    backgroundColor: 'rgba(249,115,22,.08)',
                    borderWidth: 2,
                    borderDash: [5,4],
                    fill: false,
                    tension: 0.4,
                    pointRadius: 0,
                    pointHoverRadius: 5
                }
            ]
        },
        options: {
            responsive: true, maintainAspectRatio: false,
            plugins: { legend: { position: 'top' }, tooltip: rupeeTooltip },
            scales: { y: yScale, x: xScale },
            interaction: { mode: 'nearest', axis: 'x', intersect: false }
        }
    });

    // 2. Split Doughnut
    new Chart(document.getElementById('splitDonut'), {
        type: 'doughnut',
        data: {
            labels: ['Sales', 'Expense'],
            datasets: [{ data: [<%= thisSale %>, <%= thisExpense %>], backgroundColor: ['#3b82f6','#f97316'], hoverOffset: 6 }]
        },
        options: {
            responsive: true, maintainAspectRatio: false, cutout: '72%',
            plugins: {
                legend: { position: 'bottom', labels: { padding: 16 } },
                tooltip: { callbacks: { label: ctx => ' ' + ctx.label + ': \u20B9' + ctx.parsed.toLocaleString('en-IN', {minimumFractionDigits: 0}) } }
            }
        }
    });

    // 3. Daily Sales Bar
    const dailySalesBarChart = new Chart(document.getElementById('dailySalesBar'), {
        type: 'bar',
        data: {
            labels: dailyLabels,
            datasets: [{ label: 'Sales', data: dailySalesArr, backgroundColor: 'rgba(59,130,246,.75)', borderRadius: 4, barPercentage: 0.6 }]
        },
        options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false }, tooltip: rupeeTooltip }, scales: { y: yScale, x: xScale } }
    });

    // 4. Daily Expense Bar
    const dailyExpenseBarChart = new Chart(document.getElementById('dailyExpenseBar'), {
        type: 'bar',
        data: {
            labels: dailyLabels,
            datasets: [{ label: 'Expense', data: dailyExpenseArr, backgroundColor: 'rgba(249,115,22,.75)', borderRadius: 4, barPercentage: 0.6 }]
        },
        options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false }, tooltip: rupeeTooltip }, scales: { y: yScale, x: xScale } }
    });

    // 5. Monthly 12-Month Chart
    const monthlyChartObj = new Chart(document.getElementById('monthlyChart'), {
        type: 'bar',
        data: {
            labels: monthlyLabels,
            datasets: [
                {
                    label: 'Sales',
                    data: monthlySalesArr,
                    backgroundColor: 'rgba(59,130,246,.8)',
                    borderRadius: 5,
                    barPercentage: 0.55,
                    categoryPercentage: 0.7,
                    order: 2
                },
                {
                    label: 'Expense',
                    data: monthlyExpenseArr,
                    backgroundColor: 'rgba(249,115,22,.8)',
                    borderRadius: 5,
                    barPercentage: 0.55,
                    categoryPercentage: 0.7,
                    order: 2
                },
                {
                    label: 'Sales Trend',
                    data: monthlySalesArr,
                    type: 'line',
                    borderColor: '#1d4ed8',
                    borderWidth: 2,
                    pointRadius: 3,
                    pointHoverRadius: 5,
                    fill: false,
                    tension: 0.35,
                    order: 1
                }
            ]
        },
        options: {
            responsive: true, maintainAspectRatio: false,
            plugins: { legend: { position: 'top' }, tooltip: rupeeTooltip },
            scales: {
                y: yScale,
                x: { grid: { display: false }, ticks: { maxRotation: 45 } }
            },
            interaction: { mode: 'index', intersect: false }
        }
    });

    document.getElementById('btnDlDailySales').addEventListener('click', () => {
        const a = document.createElement('a'); a.download = 'daily_sales.png'; a.href = dailySalesBarChart.toBase64Image(); a.click();
    });
    document.getElementById('btnDlDailyExpense').addEventListener('click', () => {
        const a = document.createElement('a'); a.download = 'daily_expense.png'; a.href = dailyExpenseBarChart.toBase64Image(); a.click();
    });
    document.getElementById('btnDlMonthly').addEventListener('click', () => {
        const a = document.createElement('a'); a.download = 'monthly_trend.png'; a.href = monthlyChartObj.toBase64Image(); a.click();
    });
    </script>
</body>
</html>