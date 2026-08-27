{% test positive_values(model, column_name) %}
 Select * from {{ model }} WHERE {{column_name}} <= 0
{% endtest %}