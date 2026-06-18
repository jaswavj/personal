<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<jsp:useBean id="bill" class="billing.billingBean" />
<%
response.setHeader("Cache-Control", "no-cache");
String yearStr = request.getParameter("year");
boolean allYears = "0".equals(yearStr);
int year = (!allYears && yearStr != null && yearStr.matches("\\d{4}")) ? Integer.parseInt(yearStr) : java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);

try {
    StringBuilder sb = new StringBuilder();
    sb.append("{\"year\":\"").append(allYears ? "All" : String.valueOf(year)).append("\",\"rows\":[");

    if (allYears) {
        Vector salesVec   = bill.getAllYearsSalesData();
        Vector expVec     = bill.getAllYearsExpenseData();
        Vector serviceVec = bill.getAllYearsServiceData();
        Vector cloudVec   = bill.getAllYearsCloudData();

        // Merge into a year-keyed ordered map: [clients, sales, expense, serviceCount, serviceAmount, cloudCount, cloudAmount]
        LinkedHashMap<Integer, double[]> dataMap = new LinkedHashMap<>();
        for (int i = 0; i < salesVec.size(); i++) {
            Vector r = (Vector) salesVec.elementAt(i);
            int yr = Integer.parseInt(r.elementAt(0).toString());
            double[] arr = dataMap.containsKey(yr) ? dataMap.get(yr) : new double[]{0, 0, 0, 0, 0, 0, 0};
            arr[0] = Double.parseDouble(r.elementAt(1).toString()); // clients
            arr[1] = Double.parseDouble(r.elementAt(2).toString()); // sales
            dataMap.put(yr, arr);
        }
        for (int i = 0; i < expVec.size(); i++) {
            Vector r = (Vector) expVec.elementAt(i);
            int yr = Integer.parseInt(r.elementAt(0).toString());
            double[] arr = dataMap.containsKey(yr) ? dataMap.get(yr) : new double[]{0, 0, 0, 0, 0, 0, 0};
            arr[2] = Double.parseDouble(r.elementAt(1).toString()); // expense
            dataMap.put(yr, arr);
        }
        for (int i = 0; i < serviceVec.size(); i++) {
            Vector r = (Vector) serviceVec.elementAt(i);
            int yr = Integer.parseInt(r.elementAt(0).toString());
            double[] arr = dataMap.containsKey(yr) ? dataMap.get(yr) : new double[]{0, 0, 0, 0, 0, 0, 0};
            arr[3] = Double.parseDouble(r.elementAt(1).toString()); // service count
            arr[4] = Double.parseDouble(r.elementAt(2).toString()); // service amount
            dataMap.put(yr, arr);
        }
        for (int i = 0; i < cloudVec.size(); i++) {
            Vector r = (Vector) cloudVec.elementAt(i);
            int yr = Integer.parseInt(r.elementAt(0).toString());
            double[] arr = dataMap.containsKey(yr) ? dataMap.get(yr) : new double[]{0, 0, 0, 0, 0, 0, 0};
            arr[5] = Double.parseDouble(r.elementAt(1).toString()); // cloud count
            arr[6] = Double.parseDouble(r.elementAt(2).toString()); // cloud amount
            dataMap.put(yr, arr);
        }

        long   cumClients = 0;
        double cumSales   = 0, cumExpense = 0;
        boolean first = true;
        for (Map.Entry<Integer, double[]> entry : dataMap.entrySet()) {
            int    yr            = entry.getKey();
            double[] arr         = entry.getValue();
            long   clients       = (long) arr[0];
            double sales         = arr[1];
            double expense       = arr[2];
            long   serviceCount  = (long) arr[3];
            double serviceAmount = arr[4];
            long   cloudCount    = (long) arr[5];
            double cloudAmount   = arr[6];
            cumClients += clients;
            cumSales   += sales;
            cumExpense += expense;
            double profit    = sales    - expense;
            double cumProfit = cumSales - cumExpense;
            if (!first) sb.append(",");
            first = false;
            sb.append("{")
              .append("\"month\":\"").append(yr).append("\",")
              .append("\"clients\":").append(clients).append(",")
              .append("\"sales\":").append(String.format("%.2f", sales)).append(",")
              .append("\"expense\":").append(String.format("%.2f", expense)).append(",")
              .append("\"profit\":").append(String.format("%.2f", profit)).append(",")
              .append("\"cumClients\":").append(cumClients).append(",")
              .append("\"cumExpense\":").append(String.format("%.2f", cumExpense)).append(",")
              .append("\"cumSales\":").append(String.format("%.2f", cumSales)).append(",")
              .append("\"cumProfit\":").append(String.format("%.2f", cumProfit)).append(",")
              .append("\"serviceCount\":").append(serviceCount).append(",")
              .append("\"serviceAmount\":").append(String.format("%.2f", serviceAmount)).append(",")
              .append("\"cloudCount\":").append(cloudCount).append(",")
              .append("\"cloudAmount\":").append(String.format("%.2f", cloudAmount))
              .append("}");
        }

    } else {
        Vector salesVec   = bill.getYearlySalesData(year);
        Vector expenseVec = bill.getYearlyExpenseData(year);
        Vector serviceVec = bill.getYearlyServiceData(year);
          Vector cloudVec   = bill.getYearlyCloudData(year);

        String[] monthNames = {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
        long   cumClients = 0;
        double cumSales   = 0;
        double cumExpense = 0;

        for (int i = 0; i < 12; i++) {
            Vector sRow  = (Vector) salesVec.elementAt(i);
            Vector eRow  = (Vector) expenseVec.elementAt(i);
            Vector svRow = (Vector) serviceVec.elementAt(i);
            Vector clRow = (Vector) cloudVec.elementAt(i);

            long   clients       = Long.parseLong(sRow.elementAt(1).toString());
            double sales         = Double.parseDouble(sRow.elementAt(2).toString());
            double expense       = Double.parseDouble(eRow.elementAt(1).toString());
            long   serviceCount  = Long.parseLong(svRow.elementAt(1).toString());
            double serviceAmount = Double.parseDouble(svRow.elementAt(2).toString());
            long   cloudCount    = Long.parseLong(clRow.elementAt(1).toString());
            double cloudAmount   = Double.parseDouble(clRow.elementAt(2).toString());

            cumClients += clients;
            cumSales   += sales;
            cumExpense += expense;

            double profit    = sales    - expense;
            double cumProfit = cumSales - cumExpense;

            if (i > 0) sb.append(",");
            sb.append("{")
              .append("\"month\":\"").append(monthNames[i]).append("\",")
              .append("\"clients\":").append(clients).append(",")
              .append("\"sales\":").append(String.format("%.2f", sales)).append(",")
              .append("\"expense\":").append(String.format("%.2f", expense)).append(",")
              .append("\"profit\":").append(String.format("%.2f", profit)).append(",")
              .append("\"cumClients\":").append(cumClients).append(",")
              .append("\"cumExpense\":").append(String.format("%.2f", cumExpense)).append(",")
              .append("\"cumSales\":").append(String.format("%.2f", cumSales)).append(",")
              .append("\"cumProfit\":").append(String.format("%.2f", cumProfit)).append(",")
              .append("\"serviceCount\":").append(serviceCount).append(",")
              .append("\"serviceAmount\":").append(String.format("%.2f", serviceAmount)).append(",")
              .append("\"cloudCount\":").append(cloudCount).append(",")
              .append("\"cloudAmount\":").append(String.format("%.2f", cloudAmount))
              .append("}");
        }
    }

    sb.append("]}");
    out.print(sb.toString());

} catch(Exception e) {
    out.print("{\"error\":\"" + e.getMessage().replace("\"","'") + "\"}");
}
%>
