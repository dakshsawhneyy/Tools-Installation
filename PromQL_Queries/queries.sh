## Success Rate (%)
sum(rate(http_requests_total{status_code!~"5.."}[5m]))
/
sum(rate(http_requests_total[5m]))


# Error Rate (5xx only)
sum(rate(http_requests_total{status_code=~"5.."}[5m]))
/
sum(rate(http_requests_total[5m]))


