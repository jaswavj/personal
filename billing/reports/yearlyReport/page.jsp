<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Yearly Report</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <jsp:include page="/assets/common/head.jsp" />
    <style>
        :root {
            --primary: #5c4d8a;
            --primary-dark: #4a3d78;
            --primary-light: #f0eef8;
            --green: #059669;
            --red: #dc2626;
            --orange: #f97316;
        }
        body { background: #f4f6fb; }
        .yr-header {
            background: linear-gradient(135deg, var(--primary-dark), var(--primary));
            color: #fff;
            padding: 16px 24px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .yr-header h4 { margin: 0; font-size: 1.2rem; font-weight: 700; }
        .yr-header small { opacity: .75; font-size: .82rem; }

        /* Controls */
        .ctrl-bar {
            background: #fff;
            border-radius: 10px;
            padding: 14px 18px;
            margin-bottom: 20px;
            box-shadow: 0 1px 6px rgba(0,0,0,.07);
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
        }
        .ctrl-bar label { font-weight: 600; font-size: .85rem; margin: 0; }
        .ctrl-bar select { width: 140px; font-size: .9rem; }
        .btn-load {
            background: var(--primary);
            color: #fff;
            border: none;
            border-radius: 6px;
            padding: 7px 20px;
            font-weight: 600;
            font-size: .88rem;
            cursor: pointer;
        }
        .btn-load:hover { background: var(--primary-dark); }

        /* Summary cards */
        .summary-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
            gap: 14px;
            margin-bottom: 22px;
        }
        .s-card {
            background: #fff;
            border-radius: 10px;
            padding: 14px 16px;
            box-shadow: 0 1px 6px rgba(0,0,0,.07);
            border-left: 4px solid var(--primary);
        }
        .s-card.expense     { border-left-color: var(--orange); }
        .s-card.profit       { border-left-color: var(--green); }
        .s-card.clients      { border-left-color: #3b82f6; }
        .s-card.service      { border-left-color: #8b5cf6; }
        .s-card.cloud        { border-left-color: #06b6d4; }
        .s-card-label { font-size: .75rem; color: #64748b; font-weight: 600; text-transform: uppercase; letter-spacing: .5px; }
        .s-card-value { font-size: 1.3rem; font-weight: 700; color: #0f172a; margin-top: 4px; }

        /* Table */
        .table-wrap {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 1px 6px rgba(0,0,0,.07);
            overflow: hidden;
            margin-bottom: 24px;
        }
        .table-wrap table {
            width: 100%;
            border-collapse: collapse;
            font-size: .85rem;
        }
        .table-wrap thead th {
            background: var(--primary);
            color: #fff;
            padding: 10px 12px;
            font-weight: 600;
            text-align: right;
            white-space: nowrap;
        }
        .table-wrap thead th:first-child { text-align: left; }
        .table-wrap tbody tr:nth-child(even) { background: var(--primary-light); }
        .table-wrap tbody tr:hover { background: #e9e5f5; }
        .table-wrap tbody td {
            padding: 8px 12px;
            border-bottom: 1px solid #ede9f8;
            text-align: right;
        }
        .table-wrap tbody td:first-child { text-align: left; font-weight: 600; }
        .table-wrap tfoot td {
            background: var(--primary-dark);
            color: #fff;
            font-weight: 700;
            padding: 9px 12px;
            text-align: right;
        }
        .table-wrap tfoot td:first-child { text-align: left; }
        .text-profit  { color: var(--green); font-weight: 600; }
        .text-loss    { color: var(--red);   font-weight: 600; }

        /* Charts */
        .chart-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
            margin-bottom: 24px;
        }
        @media (max-width: 768px) { .chart-row { grid-template-columns: 1fr; } }
        .chart-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 1px 6px rgba(0,0,0,.07);
            padding: 16px;
        }
        .chart-card h6 {
            font-size: .82rem;
            font-weight: 700;
            color: var(--primary-dark);
            text-transform: uppercase;
            letter-spacing: .5px;
            margin-bottom: 12px;
            padding-bottom: 8px;
            border-bottom: 2px solid var(--primary-light);
        }
        .spinner-wrap { text-align: center; padding: 40px; color: #94a3b8; }
    </style>
</head>
<body>
    <jsp:include page="/assets/navbar/navbar.jsp" />
    <div class="container-fluid px-3 py-3">

        <div class="yr-header">
            <h4><i class="fa fa-chart-bar me-2"></i>Yearly Business Report</h4>
            <small>Month-wise Sales, Expense &amp; Profit Analysis</small>
        </div>

        <!-- Controls -->
        <div class="ctrl-bar">
            <label for="yearSel">Select Year:</label>
            <select id="yearSel" class="form-select form-select-sm">
                <option value="0">All</option>
                <%
                int curYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                for (int y = curYear; y >= curYear - 6; y--) {
                %>
                <option value="<%= y %>" <%= (y == curYear ? "selected" : "") %>><%= y %></option>
                <% } %>
            </select>
            <button class="btn-load" onclick="loadReport()"><i class="fa fa-sync me-1"></i>Load</button>
            <span id="loadMsg" style="font-size:.82rem;color:#64748b;"></span>
        </div>

        <!-- Summary Cards -->
        <div class="summary-cards" id="summaryCards">
            <div class="s-card clients"><div class="s-card-label">Total Client</div><div class="s-card-value" id="sumClients">—</div></div>
            <div class="s-card"><div class="s-card-label">Total Sales</div><div class="s-card-value" id="sumSales">—</div></div>
            <div class="s-card service">
                <div class="s-card-label">Service Work</div>
                <div class="s-card-value" id="sumServiceAmount">—</div>
                <div style="font-size:.78rem;color:#64748b;margin-top:3px;">Count: <span id="sumServiceCount" style="font-weight:700;color:#0f172a;">—</span></div>
            </div>
            <div class="s-card cloud">
                <div class="s-card-label">Cloud Profit</div>
                <div class="s-card-value" id="sumCloudAmount">—</div>
                <div style="font-size:.78rem;color:#64748b;margin-top:3px;">Count: <span id="sumCloudCount" style="font-weight:700;color:#0f172a;">—</span></div>
            </div>
            <div class="s-card expense"><div class="s-card-label">Total Expense</div><div class="s-card-value" id="sumExpense">—</div></div>
            <div class="s-card profit"><div class="s-card-label">Net Profit</div><div class="s-card-value" id="sumProfit">—</div></div>
        </div>

        <!-- Charts -->
        <div class="chart-row">
            <div class="chart-card">
                <h6><i class="fa fa-line-chart me-1"></i>Cumulative — Overall Sale &amp; Overall Inv (Expense)</h6>
                <canvas id="cumulChart" height="200"></canvas>
            </div>
            <div class="chart-card">
                <h6><i class="fa fa-bar-chart me-1"></i>Monthly — Sale &amp; Ads (Expense)</h6>
                <canvas id="monthlyChart" height="200"></canvas>
            </div>
        </div>

        <!-- Table -->
        <div class="table-wrap">
            <table id="reportTable">
                <thead>
                    <tr>
                        <th>Month</th>
                        <th>Clients</th>
                        <th>Sale (₹)</th>
                        <th>Service/Cloud (₹)</th>
                        <th>Ads (₹)</th>
                        <th>Profit (₹)</th>
                        <th>Overall Inv (₹)</th>
                        <th>Overall Sale (₹)</th>
                        <th>Overall Profit (₹)</th>
                    </tr>
                </thead>
                <tbody id="reportBody">
                    <tr><td colspan="9" class="spinner-wrap"><i class="fa fa-spinner fa-spin me-1"></i>Loading...</td></tr>
                </tbody>
                <tfoot id="reportFoot"></tfoot>
            </table>
        </div>

    </div>

    <script>
    <%
    String ctx = request.getContextPath();
    %>
    const contextPath = '<%= ctx %>';

    let cumulChartObj = null, monthlyChartObj = null;

    function fmt(n) {
        return parseFloat(n).toLocaleString('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2});
    }

    function loadReport() {
        const year = document.getElementById('yearSel').value;
        document.getElementById('loadMsg').textContent = 'Loading...';
        document.getElementById('reportBody').innerHTML = '<tr><td colspan="9" class="spinner-wrap"><i class="fa fa-spinner fa-spin me-1"></i>Loading...</td></tr>';
        document.getElementById('reportFoot').innerHTML = '';

        fetch(contextPath + '/reports/yearlyReport/getData.jsp?year=' + year)
            .then(r => r.json())
            .then(data => {
                document.getElementById('loadMsg').textContent = '';
                renderTable(data.rows);
                renderCharts(data.rows);
                renderSummary(data.rows);
            })
            .catch(err => {
                document.getElementById('loadMsg').textContent = 'Error loading data.';
                console.error(err);
            });
    }

    function renderSummary(rows) {
        const last = rows[rows.length - 1];
        document.getElementById('sumClients').textContent = last.cumClients;
        document.getElementById('sumSales').textContent = '₹' + fmt(last.cumSales);
        const totalExp = rows.reduce((a, r) => a + parseFloat(r.expense), 0);
        const totalProfit = rows.reduce((a, r) => a + parseFloat(r.profit), 0);
        document.getElementById('sumExpense').textContent = '₹' + fmt(totalExp);
        const totalServiceCount  = rows.reduce((a, r) => a + parseInt(r.serviceCount  || 0), 0);
        const totalServiceAmount = rows.reduce((a, r) => a + parseFloat(r.serviceAmount || 0), 0);
        const totalCloudCount    = rows.reduce((a, r) => a + parseInt(r.cloudCount  || 0), 0);
        const totalCloudAmount   = rows.reduce((a, r) => a + parseFloat(r.cloudAmount || 0), 0);
        const netProfit = totalProfit + totalServiceAmount + totalCloudAmount;
        const profEl = document.getElementById('sumProfit');
        profEl.textContent = '₹' + fmt(netProfit);
        profEl.style.color = netProfit >= 0 ? 'var(--green)' : 'var(--red)';
        document.getElementById('sumServiceCount').textContent = totalServiceCount + ' bills';
        document.getElementById('sumServiceAmount').textContent = '₹' + fmt(totalServiceAmount);
        document.getElementById('sumCloudCount').textContent = totalCloudCount + ' bills';
        document.getElementById('sumCloudAmount').textContent = '₹' + fmt(totalCloudAmount);
    }

    function renderTable(rows) {
        const tbody = document.getElementById('reportBody');
        const tfoot = document.getElementById('reportFoot');
        let html = '';
        let totSales = 0, totExp = 0, totClients = 0, totSvcCloud = 0, totProfit = 0;
        let runProfit = 0;

        rows.forEach(r => {
            const rowSvcCloud = parseFloat(r.serviceAmount || 0) + parseFloat(r.cloudAmount || 0);
            const rowProfit = parseFloat(r.profit) + rowSvcCloud;
            runProfit += rowProfit;
            const pClass = rowProfit >= 0 ? 'text-profit' : 'text-loss';
            const cpClass = runProfit >= 0 ? 'text-profit' : 'text-loss';
            html += `<tr>
                <td>${r.month}</td>
                <td>${r.clients}</td>
                <td>${fmt(r.sales)}</td>
                <td>${fmt(rowSvcCloud)}</td>
                <td>${fmt(r.expense)}</td>
                <td class="${pClass}">${fmt(rowProfit)}</td>
                <td>${fmt(r.cumExpense)}</td>
                <td>${fmt(r.cumSales)}</td>
                <td class="${cpClass}">${fmt(runProfit)}</td>
            </tr>`;
            totSales   += parseFloat(r.sales);
            totExp     += parseFloat(r.expense);
            totSvcCloud += rowSvcCloud;
            totClients += parseInt(r.clients);
            totProfit  += rowProfit;
        });
        tbody.innerHTML = html;

        const fpClass = totProfit >= 0 ? '#6ee7b7' : '#fca5a5';
        tfoot.innerHTML = `<tr>
            <td>Total</td>
            <td>${totClients}</td>
            <td>${fmt(totSales)}</td>
            <td>${fmt(totSvcCloud)}</td>
            <td>${fmt(totExp)}</td>
            <td style="color:${fpClass}">${fmt(totProfit)}</td>
            <td colspan="3"></td>
        </tr>`;
    }

    function renderCharts(rows) {
        const labels = rows.map(r => r.month);
        const svcCloud = rows.map(r => parseFloat(r.serviceAmount || 0) + parseFloat(r.cloudAmount || 0));
        const salesOnly = rows.map(r => parseFloat(r.sales));
        const expense = rows.map(r => parseFloat(r.expense));
        let runSvcCloud = 0;
        const cumSales  = rows.map(r => {
            runSvcCloud += parseFloat(r.serviceAmount || 0) + parseFloat(r.cloudAmount || 0);
            return parseFloat(r.cumSales) + runSvcCloud;
        });
        const cumInv = rows.map(r => parseFloat(r.cumExpense));

        // Cumulative chart (line)
        if (cumulChartObj) cumulChartObj.destroy();
        cumulChartObj = new Chart(document.getElementById('cumulChart'), {
            type: 'line',
            data: {
                labels,
                datasets: [
                    {
                        label: 'Overall Sale + Service/Cloud (₹)',
                        data: cumSales,
                        borderColor: '#5c4d8a',
                        backgroundColor: 'rgba(92,77,138,.12)',
                        borderWidth: 2.5,
                        fill: true,
                        tension: 0.4,
                        pointRadius: 4
                    },
                    {
                        label: 'Overall Inv / Expense (₹)',
                        data: cumInv,
                        borderColor: '#f97316',
                        backgroundColor: 'rgba(249,115,22,.10)',
                        borderWidth: 2,
                        fill: false,
                        tension: 0.4,
                        pointRadius: 4,
                        borderDash: [5,4]
                    }
                ]
            },
            options: {
                responsive: true,
                interaction: { mode: 'index', intersect: false },
                plugins: { legend: { position: 'top', labels: { font: { size: 11 } } } },
                scales: {
                    y: { beginAtZero: true, ticks: { font: { size: 10 } } }
                }
            }
        });

        // Monthly bar chart
        if (monthlyChartObj) monthlyChartObj.destroy();
        monthlyChartObj = new Chart(document.getElementById('monthlyChart'), {
            type: 'bar',
            data: {
                labels,
                datasets: [
                    {
                        label: 'Sale (₹)',
                        data: salesOnly,
                        backgroundColor: 'rgba(92,77,138,.8)',
                        borderRadius: 4,
                        barPercentage: 0.7,
                        categoryPercentage: 0.75
                    },
                    {
                        label: 'Service/Cloud (₹)',
                        data: svcCloud,
                        backgroundColor: 'rgba(6,182,212,.85)',
                        borderRadius: 4,
                        barPercentage: 0.7,
                        categoryPercentage: 0.75
                    },
                    {
                        label: 'Ads/Expense (₹)',
                        data: expense,
                        backgroundColor: 'rgba(249,115,22,.8)',
                        borderRadius: 4,
                        barPercentage: 0.7,
                        categoryPercentage: 0.75
                    }
                ]
            },
            options: {
                responsive: true,
                interaction: { mode: 'index', intersect: false },
                plugins: { legend: { position: 'top', labels: { font: { size: 11 } } } },
                scales: {
                    x: { ticks: { font: { size: 10 } } },
                    y: { beginAtZero: true, ticks: { font: { size: 10 } } }
                }
            }
        });
    }

    // Auto-load on page ready
    document.addEventListener('DOMContentLoaded', loadReport);
    </script>
</body>
</html>
